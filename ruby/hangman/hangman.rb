#! /usr/bin/ruby
# A hangman game that automatically saves and loads game progress
# state = word used, letters guessed, guesses remaining
require 'yaml'


class GameState
  attr_accessor :word, :guessed, :remaining
  def initialize
    @word = nil
    @guessed = []
    @remaining = 6
  end
end



class IO
  def initialize
  end

  def load_or_new_game
    state = nil
    if File.exists?('save_game.yaml')
      state = File.open('save_game.yaml','r') {|f| YAML::load(f)}
    else
      state = new_game
    end
    state
  end

  def new_game
    game = GameState.new
    game.word = get_word
    game
  end

  def get_word
    word = File.read('5desk.txt').lines.select {|l| (5..12).cover?(l.strip.size)}.sample.strip.upcase
    word.split('')
  end

  def save_game(state)
    File.open('save_game.yaml', 'w') {|f| YAML::dump(state, f)}
  end

  def delete_save
    if File.exists?('save_game.yaml')
      File.delete('save_game.yaml')
    end
  end
end



class Game
  attr_reader :state, :running
  def initialize
    @io = IO.new
    @state = @io.load_or_new_game
    @running = true
  end

  def prompt_user
    display_board
    while true
      puts "Letters guessed: #{@state.guessed.join(',')}"
      puts "#{@state.remaining} moves left"
      puts "Please enter your guess or type 'exit'"
      response = gets.chomp.upcase
      break if quit_game(response)
      break if response.length == 1 and
               ('A'..'Z').include?(response) and
               not @state.guessed.include? response
    end
    unless @state.word.any? {|letter| letter == response }
      @state.remaining -= 1
    end
    @state.guessed.push response
    @state.guessed = @state.guessed.sort
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
    @io.save_game(@state)
    victory if @state.word.all? {|l| @state.guessed.include? l}
    game_over if @state.remaining < 1
  end

  def victory
    display_board
    puts "You won!"
    @io.delete_save
    @running = false
  end

  def game_over
    display_board
    answer = @state.word.join(' ')
    puts "The word was #{answer}"
    puts "You lose!"
    @io.delete_save
    @running = false
  end

  def quit_game(response)
    if response == 'EXIT'
      puts 'exiting'
      @io.save_game(@state)
      @running = false
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
      game.update_board if game.running
    end
    break unless game.continue
  end
end

main
