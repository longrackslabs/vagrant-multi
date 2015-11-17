# config.ru
require 'rubygems'
require 'sinatra'
require File.expand_path '../hello-ruby.rb', __FILE__

run Sinatra::Application
