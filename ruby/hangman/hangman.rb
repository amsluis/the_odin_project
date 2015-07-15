#! /usr/bin/ruby
# A hangman game that automatically saves and loads game progress
# state = word used, letters guessed, guesses remaining
require 'yaml'
include ObjectSpace

class GameState
  attr_accessor :word, :guessed, :remaining

  def initialize
    @word = nil
    @guessed = []
    @remaining = 6
  end
end

class Game
  attr_reader :state, :running
  def initialize
    @state = load_or_new_game
    @running = true
  end

  def load_or_new_game
    if File.exists?('save_game.yaml')
      File.open('save_game.yaml','r') {|f| YAML::load(f)}
    else
      new_game
    end
  end

  def new_game
    game = GameState.new
    game.word = get_word
    game
  end

  def save_game
    File.open('save_game.yaml', 'w') {|f| YAML::dump(@state, f)}
  end

  def prompt_user
    display_board
    while true
      puts "You have guessed #{@state.guessed.join(',')}"
      puts "Please enter your guess or type 'exit'"
      response = gets.chomp.upcase
      break if quit_game(response)
      break if response.length == 1 and
               ('A'..'Z').include?(response) and
               not @state.guessed.include? response
    end
    @state.remaining -= 1
    @state.guessed.push response
    response
  end

  def display_board
    display = ' '
    @state.word.each do |letter|
      if @state.guessed.include? letter
        display += letter + ' '
      else
        display += '_ '
      end
    end
    puts display
  end

  def update_board
    victory if @state.word.all? {|l| @state.guessed.include? l}
    game_over if @state.remaining < 1
    save_game
    @state.guessed.sort
  end

  def get_word
    word = File.read('5desk.txt').lines.select {|l| (5..12).cover?(l.strip.size)}.sample.strip.upcase
    word.split('')
  end

  def victory
    display_board
    puts "You won!"
    end_game
  end

  def game_over
    display_board
    puts "You lose!"
    end_game
  end

  def end_game
    puts 'trying to delete'
    ObjectSpace.each_object(File) {|x| p x}
    File.delete('save_game.yaml')            #FIXME - not deleting file
    @running = false
  end

  def quit_game(response)
    if response == 'EXIT'
      puts 'exiting'
      save_game
      @running = false               #TODO - check that this properly quits, breaks while loop in prompt
    end
    response == 'EXIT'
  end

  def continue
    puts "Would you like to play again?"
    ['yes','sure','okay','y','i would','yeah','yup'].include? gets.chomp.downcase
  end
end

def main
  while true
    game = Game.new
    while game.running
      game.prompt_user
      p game.state.word
      game.display_board if game.running
      game.update_board if game.running
    end
    break unless game.continue
  end
end

main
