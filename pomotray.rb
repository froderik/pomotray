#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV

# need a window to make the menu happy
window = Qt::MainWindow.new

def tomato
  Qt::Icon.new 'tomato.png'
end

def tomato_menu window
  Qt::Menu.new( window ) do |menu|
    menu.add_action 'start'
    menu.add_action 'stop'
    menu.add_action 'pause'
  end
end

pomotray = Qt::SystemTrayIcon.new tomato
pomotray.context_menu = tomato_menu window
pomotray.show

application.exec


