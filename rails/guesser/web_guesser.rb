require 'sinatra'
require 'sinatra/reloader'

magic_num = rand(101)
get '/' do
  "The secret number is #{magic_num}"
end
