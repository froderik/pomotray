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
    self.set_tool_tip "#{seconds_left/60}:#{seconds_left%60}"
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
      start_action = menu.add_action 'start'
      connect start_action, SIGNAL( :triggered ), self, SLOT( :start )
      
      reset_action = menu.add_action 'reset'
      connect reset_action, SIGNAL( :triggered ), self, SLOT( :reset )
      
      pause_action = menu.add_action 'pause'
      connect pause_action, SIGNAL( :triggered ), self, SLOT( :pause )
    end
  end

  def seconds_left
    @count_down_minutes * 60 - @seconds_elapsed
  end

  def tick
    @seconds_elapsed += 1
    update_minutes
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


