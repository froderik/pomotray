#!/usr/bin/env ruby

require 'Qt'

Qt::Application::set_style 'plastique'
application = Qt::Application.new ARGV

tomato = Qt::Icon.new 'tomato.png'
Qt::SystemTrayIcon.new( tomato, application ).show

application.exec


