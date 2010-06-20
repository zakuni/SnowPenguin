#!/usr/bin/env ruby
# coding: utf-8

require 'simple-oauth'
require 'rubygems'
require 'json'

ary = Array.new

open("key.csv"){|file|
  ary = file.readlines
}

ary.each{ |line|
  line.chomp!
}

CONSUMER_KEY =  ary[0]
CONSUMER_SECRET = ary[1]
TOKEN = ary[2]
TOKEN_SECRET = ary[3]


simple_oauth = SimpleOAuth.new(CONSUMER_KEY, CONSUMER_SECRET, TOKEN, TOKEN_SECRET)

# Tweetの投稿

response = simple_oauth.post('http://twitter.com/statuses/update.json', {
  :status => "くそう、なんて汚いコードだ"
})
raise "Request failed: #{response.code}" unless response.code.to_i == 200


# TimeLineの取得
response = simple_oauth.get('http://twitter.com/statuses/friends_timeline.json?count=10')
raise "Request failed: #{response.code}" unless response.code.to_i == 200
JSON.parse(response.body).each do |status|
  puts "#{status['user']['screen_name']}: #{status['text']}"
  print "\n"
end
