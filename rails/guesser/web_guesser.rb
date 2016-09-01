require 'sinatra'
require 'sinatra/reloader'

$magic_num = rand(101)

get '/' do
  guess = params["guess"]
  message, format= check_guess(guess)
  erb :index, :locals => {:number => $magic_num, :message => message, :format => format}
end

def check_guess(guess)
  guess = guess.to_i
  if guess.nil?
    return "Please enter a number", "background: gray;"
  elsif guess > $magic_num
    return "Guess is too high", "background: red;"
  elsif guess < $magic_num
    return "Guess is too low", "background: blue;"
  elsif guess == $magic_num
    return "Correct!", "background: green;"
  end
end
