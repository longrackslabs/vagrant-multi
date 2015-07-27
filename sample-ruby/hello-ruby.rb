# hello-ruby.rb
require 'sinatra'
require 'json'
require 'sinatra/jsonp'
set bind: '0.0.0.0'

get '/' do
  time1 = Time.new
  'Hello World: Ruby From Vagrant! ' + time1.inspect
end

# Sinatra Part
quotes = [
  'Just one thing, Dude. Do ya have to use so many cuss words?',
  'Hey, this is a private residence man.',
  'Hello. Mein dizbatcher says zere iss somezing wrong mit deine kable.',
  'Vee vant zat money, Lebowski.',
  'Uh, yeah. Probably a vagrant, slept in the car. Or perhaps just used it as a toilet and moved on.',
  'Your name is Lebowski, Lebowski. Your wife is Bunny.',
  'You are joking. But perhaps you are right.',
  'I\'m staying. I\'m finishing my coffee. Enjoying my coffee.',
  'Tomorrow vee come back and cut off your Johnson.',
  'Has the whole world gone CRAZY?! Am I the only one who gives a shit about the rules?! MARK IT ZERO!'

]

get '/quote' do
  jsonp quotes.shuffle.first
end
