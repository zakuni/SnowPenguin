require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'

get '/' do
  haml :index
end

get '/stylesheet.css' do
  sass :stylesheet
end
