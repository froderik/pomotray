#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV


class Pomotray < Qt::SystemTrayIcon
  slots :tick
  
  def initialize
    super tomato
    self.context_menu = menu
    @timer = Qt::Timer.new
    @timer.set_interval 1000

    self.connect @timer, SIGNAL( :timeout ), self, SLOT( :tick )
    
    @seconds_elapsed = 0
    @count_down_minutes = 25
    update_minutes
    @timer.start
    show
  end

  def update_minutes
    self.set_tool_tip "#{seconds_left/60}:#{seconds_left%60}"
  end

  def tomato
    Qt::Icon.new 'tomato.png'
  end

  def menu
    # need a window to make the menu happy
    window = Qt::MainWindow.new
    Qt::Menu.new( window ) do |menu|
      menu.add_action 'start'
      menu.add_action 'stop'
      menu.add_action 'pause'
    end
  end

  def seconds_left
    @count_down_minutes * 60 - @seconds_elapsed
  end

  def tick
    @seconds_elapsed += 1
    update_minutes
  end
end

pomotray = Pomotray.new

application.exec


