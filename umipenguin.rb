#!/usr/bin/env ruby
# coding: utf-8

#require 'simple-oauth'
require 'rubygems'
require 'json'
gem 'twitter'
require 'twitter'
require 'tk'

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

  oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
  oauth.authorize_from_access(TOKEN, TOKEN_SECRET)

  client = Twitter::Base.new(oauth)

#simple_oauth = SimpleOAuth.new(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET)

# Tweetの投稿

if ARGV[0] != nil
  client.update(ARGV[0])
end

# TimeLineの取得

=begin

response = simple_oauth.get('http://twitter.com/statuses/friends_timeline.json?count=10')
raise "Request failed: #{response.code}" unless response.code.to_i == 200
JSON.parse(response.body).each do |status|
  puts "#{status['user']['screen_name']}: #{status['text']}"
  print "\n"
end

=end

#client.friends_timeline.each  { |tweet| puts tweet.inspect,"\n" }
#client.user_timeline.each     { |tweet| puts tweet.inspect }
#client.replies.each           { |tweet| puts tweet.inspect }

e = TkEntry.new('width'=>30).pack
TkButton.new(nil, 'text'=>'tweet', 'command'=>proc{client.update("#{e.value}")}).pack('side'=>'right')
Tk.mainloop

