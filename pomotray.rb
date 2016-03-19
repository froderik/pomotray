#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV


class Pomotray < Qt::SystemTrayIcon
  def initialize
    super tomato
    self.context_menu = menu
    show
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
end


pomotray = Pomotray.new
#pomotray.show

application.exec


