require 'sinatra'
require 'sinatra/reloader'

$magic_num = rand(101)
$prev_guess = nil
$attempts = 6

get '/' do
  # get URL paramters
  guess = params["guess"]
  cheat = params["cheat"]
  # process params
  if cheat
    message = "The number is #{$magic_num}"
    format = "background: yellow"
  elsif $attempts == 0
    message, format = reset()
  else
    message, format = check_guess(guess)
    $prev_guess = guess
    $attempts -= 1
  end
  # render view
  erb :index, :locals => {:number => $magic_num, :message => message, :format => format}
end

def check_guess(guess)
  guess = guess.to_i
  if $prev_guess.nil?
    return "Please enter a number", "background: gray;"
  elsif guess > $magic_num
    return "You guessed #{guess} but that is too high.\n#{$attempts} attempts remaining.", "background: red;"
  elsif guess < $magic_num
    return "You guessed #{guess} but that is too low.\n#{$attempts} attempts remaining.", "background: blue;"
  elsif guess == $magic_num
    return "Correct! the number was #{guess}!", "background: green;"
  end
end

def reset()
  $attempts = 6
  $prev_guess = nil
  $magic_num = rand(101)
  return "Out of turns, you lose.\n Try again!", "background: red;"
end
