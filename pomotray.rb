#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV


class Pomotray < Qt::SystemTrayIcon
  slots :tick, :start, :pause, :reset
  
  def initialize
    super tomato
    self.context_menu = menu
    @timer = Qt::Timer.new
    @timer.set_interval 1000

    self.connect @timer, SIGNAL( :timeout ), self, SLOT( :tick )

    reset_numbers
    show
  end

  def update_minutes
    self.set_tool_tip "#{minutes_left}:#{'%02d' % (seconds_left%60)}"
  end

  def tomato
    Qt::Icon.new 'tomato.png'
  end

  def reset_numbers
    @seconds_elapsed = 0
    @count_down_minutes = 25    
    update_minutes
  end

  def menu
    # need a window to make the menu happy
    window = Qt::MainWindow.new
    Qt::Menu.new( window ) do |menu|
      menu_item menu, :start
      menu_item menu, :reset
      menu_item menu, :pause
    end
  end

  def menu_item menu, name
    menu_action = menu.add_action name.to_s
    connect menu_action, SIGNAL( :triggered ), self, SLOT( name )
  end

  def seconds_left
    @count_down_minutes * 60 - @seconds_elapsed
  end

  def minutes_left
    seconds_left/60
  end

  def tick
    @seconds_elapsed += 1
    update_minutes
    if done?
      show_time_is_up_message
      reset_numbers
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


