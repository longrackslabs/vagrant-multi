# hello-ruby.rb
require 'sinatra'

set bind: '0.0.0.0'

get '/' do
  time1 = Time.new
  'Hello World: Ruby From Vagrant! ' + time1.inspect
end
