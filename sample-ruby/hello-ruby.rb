# hello-ruby.rb
require 'sinatra'
require 'json'

set bind: '0.0.0.0'

get '/' do
  time1 = Time.new
  'Hello World: Ruby From Vagrant! ' + time1.inspect
end

class DudeQuoteServer
  attr_reader :quotes
  def initialize
    @quotes = %w(Just one thing, Dude. Do ya have to use so many cuss words?)
    @quotes.concat %w(Hey, this is a private residence man.)
  end
end

# Sinatra Part
get '/quote' do
  return_message = {}
  return_message[:quote] = 'Hello. Mein dizbatcher says zere iss somezing wrong mit deine kable.'

  return_message.to_json
end
