#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV

class PomotrayMenu < Qt::Menu
  def initialize slot_machine
    super invisible_window
    @slot_machine = slot_machine
    add_menu_item :start
    add_menu_item :reset
    add_menu_item :pause
  end

  def add_menu_item name
    menu_action = add_action name.to_s
    connect menu_action, SIGNAL( :triggered ), @slot_machine, SLOT( name )
  end

  def invisible_window
    Qt::MainWindow.new
  end
end

class Pomotimer < Qt::Timer
  def initialize interval, tickable
    super()
    set_interval 1000
    self.connect self, SIGNAL( :timeout ), tickable, SLOT( :tick )
  end
end

class Pomotray < Qt::SystemTrayIcon
  slots :tick, :start, :pause, :reset
  
  def initialize
    super tomato
    @timer = Pomotimer.new 1000, self
    self.context_menu = PomotrayMenu.new self
    reset_numbers
    show
  end

  def tomato
    Qt::Icon.new 'tomato.png'
  end

  def printable_time_left
    "#{minutes_left}:#{'%02d' % (seconds_left % 60)}"
  end

  def seconds_left
    @count_down_minutes * 60 - @seconds_elapsed
  end

  def minutes_left
    seconds_left/60
  end

  def update_minutes
    self.set_tool_tip printable_time_left
  end

  def reset_numbers
    @seconds_elapsed = 0
    @count_down_minutes = 25
    update_minutes
  end

  def tick
    @seconds_elapsed += 1
    update_minutes
    if done?
      show_time_is_up_message
      reset
    end
  end

  def show_time_is_up_message
    show_message 'Time is up', 'Take a break'
  end

  def done?
    @seconds_elapsed > @count_down_minutes * 60
  end

  def start
    @timer.start
  end

  def pause
    @timer.stop
  end

  def reset
    @timer.stop
    reset_numbers
  end
end

pomotray = Pomotray.new

application.exec


