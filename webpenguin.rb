# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'em-http'
require 'json'

get '/' do
  haml :index
end

get '/stylesheet.css' do
  sass :stylesheet
end

get '/hello/:name' do
  "Hello #{params[:name]}!"
end


get '/guess/:who' do
  pass unless params[:who] == 'zakuni'
  "Yes! I am!"
end

get '/guess/*' do
  "No! I'm not!"
end


get '/tweets' do
  content_type 'text/html', :charset => 'utf-8'
  TWEETS.map {|tweet| "<p><b>#{tweet['user']['screen_name']}</b>: #{tweet['text']}</p>" }.join
end

class RingBuffer < Array
  def initialize(size)
    @max = size
    super(0)
  end

  def push(object)
    shift if size == @max
    super
  end
end

TWEETS = RingBuffer.new(10)
STREAMING_URL = 'http://stream.twitter.com/1/statuses/sample.json'

def handle_tweet(tweet)
  return unless tweet['text']
  TWEETS.push(tweet)
end

EM.schedule do
  http = EM::HttpRequest.new(STREAMING_URL).get :head => { 'Authorization' => [ 'user', 'pass' ] }
  buffer = ""
  http.stream do |chunk|
    buffer += chunk
    while line = buffer.slice!(/.+\r?\n/)
      handle_tweet JSON.parse(line)
    end
  end
end
