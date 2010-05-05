#-*- coding:utf-8 -*-
# 2010/2/8 作成

require 'rubygems'
require 'hotcocoa'

# Replace the following code with your own hotcocoa code

class Application

  include HotCocoa
  
  def start
    application :name => "海ペンギン" do |app|
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "海ペンギン", do |win|
      t = text_field(layout: {expand: :width, start: false})
      btn = button(title: "R", layout: {align: :top})
      btn.on_action { t.stringValue = "reloaded" }
        win << label(:text => "Hello from HotCocoa", :layout => {:start => true})
      	win << t

        win << btn
        win.will_close { exit }
      end
    end
  end
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
end

Application.new.start
