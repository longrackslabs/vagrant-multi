# hello-ruby.rb
require 'sinatra'
require 'json'

set bind: '0.0.0.0'

get '/' do
  time1 = Time.new
  'Hello World: Ruby From Vagrant! ' + time1.inspect
end

# Sinatra Part
quotes = [
  'Just one thing, Dude. Do ya have to use so many cuss words?',
  'Hey, this is a private residence man.',
  'Hello. Mein dizbatcher says zere iss somezing wrong mit deine kable.'
]

get '/quote' do
  return_message = {}

  return_message[:quote] = quotes.shuffle.first

  return_message.to_json
end
