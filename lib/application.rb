# -*- coding: utf-8 -*-
require 'rubygems'
require 'hotcocoa'
require 'simple-oauth'
require 'json'

gem 'twitter'
require 'twitter'


class Application

  include HotCocoa
  
  
  ary = Array.new

  open("key.csv"){|file|
    ary = file.readlines
  }
    
  ary.each{ |line|
    line.chomp!
  }
  
  CONSUMER_KEY = ary[0]
  CONSUMER_SECRET = ary[1]
  TOKEN = ary[2]
  TOKEN_SECRET = ary[3]
  
#  simple_oauth = SimpleOAuth.new(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET)

  oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
  oauth.authorize_from_access(TOKEN, TOKEN_SECRET)

  client = Twitter::Base.new(oauth)

  a = "macruby"
#  client.update(a)

  def twitter

    
=begin
    response = simple_oauth.post('http://twitter.com/statuses/update.json', {
                                   :status => "ぬうう"
                                 })
=end
  end

  def start
    application :name => "Umipenguin" do |app|
      tweet = "ツイート"
#      client.update('チョコボの不思議なダンジョン２とか、今なら楽にクリアできるのかしら')
      
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "Umipenguin" do |win|
        win << label(:text => tweet, :layout => {:start => false})
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
