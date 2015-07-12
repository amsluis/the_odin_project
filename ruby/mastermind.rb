#! /usr/bin/ruby
# Master Mind game
# Guess pattern of 4 pegs with 6 possible colors
# Colored peg indicates a guess peg at the correct position and color
# White peg indicates correct color only, for each peg correct

class Board
  attr_reader :board
  def initialize
    puts "Welcome to Mastermind!"
    @board = (0...4).map { (65 + rand(6)).chr }
  end

  def score_guess(guess)
    black = 0
    (0...4).each do |i|
      black += 1 if guess[i] == @board[i]
    end
    white = 0
    guess.uniq.each do |letter|
      white += @board.count(letter)
    end
    return [black,white]
  end
end

class Game
  attr_accessor :running
  def initialize
    @running = true
    @score = [0,0]
    @moves = 12
  end

  def prompt
    while true
      puts "~~~Enter your guess~~~ Choose 4 letters from A to F\n\n"
      response = gets.chomp.upcase.split('')
      unless valid?(response)
        puts "Invalid Response"
      end
      return response if valid?(response)
    end
  end

  def valid?(response)
    return response.all? {|letter| ['A','B','C','D','E','F'].any? {|l| letter.include?(l)}} &&
      response.length == 4
  end

  def update(score)
    puts "\n"
    puts " #{score[0]} letters are correct and in the right location."
    puts " #{score[1]} letters are correct."
    @moves -= 1
    (0...2).each {|i| @score[i] += score[i]}
    victory if score[0] == 4
    puts " #{@moves} guesses remaining"
    game_over if @moves < 1
  end

  def continue?
    puts "Would you like to play again?"
    response = gets.chomp
    ['yes','y','sure','okay'].any? {|word| response.include?(word)}
  end

  def victory
    puts "You win!"
    puts "Your score was #{@score[0]} black and #{@score[1]} white."
    @running = false
  end

  def game_over
    puts "You lose!"
    puts "Your score was #{@score[0]} black and #{@score[1]} white."
    @running = false
  end
end

def main
  while true
    game = Game.new
    board = Board.new
    while game.running
      guess = game.prompt
      score = board.score_guess(guess)
      game.update(score)
    end
    break unless game.continue?
  end
end

if __FILE__ == $0
  main()
end
