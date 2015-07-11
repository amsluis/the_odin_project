#! /usr/bin/ruby
# Create a command line tic tac toe game with a focus on clear
# object oriented design
#
# Main components:
#   game board
#   player 1
#   player 2 (computer AI)
#   main game loop
#   no need for event listener - event driven
#
# AI:
#   protect from win
#   get center
#   get corner
#   make pair

class Board

  def initialize
    @blank  = ['     ',
               '     ',
               '     ',
               '     ',
               '     ']
    @x      = ['X   X',
               ' X X ',
               '  X  ',
               ' X X ',
               'X   X']
    @o      = [' XXX ',
               'X   X',
               'X   X',
               'X   X',
               ' XXX ']
    @board  = [@blank]*9
  end

  def draw_board
    (0..4).each do |line|
      puts " #{@board[0][line]} | #{@board[1][line]} | #{@board[2][line]} "
    end
    puts "======================="
    (0..4).each do |line|
      puts " #{@board[3][line]} | #{@board[4][line]} | #{@board[5][line]} "
    end
    puts "======================="
    (0..4).each do |line|
      puts " #{@board[6][line]} | #{@board[7][line]} | #{@board[8][line]} "
    end
  end

  def make_move(move, player)

  end
end

class Player

  def initialize
  end

  def get_move
  end

  def human
  end

  def ai
  end

end

class Game
  attr :running, :exit

  def initialize
    @running = true
    @exit = false
    @player = nil
    get_player_order
  end

  def get_players
    if @player == 'first'
      return Player.new.human, Player.new.ai
    elsif @player == 'second'
      return Player.new.ai, Player.new.human
    else
      raise "no player found"
    end
  end

  private

  def get_player_order
    puts "Would you like to go first or second?"
    response = gets.chomp.downcase
    if ['first','1st','1'].any? { |word| response.include?(word) }
      puts 'first selected'
      @player = 'first'
    elsif ['second','2st','2'].any? { |word| response.include?(word) }
      puts 'second selected'
      @player = 'second'
    else
      puts 'invalid'
      get_player_order
    end
  end
end

Board.new.draw_board

def main
  while true
    game = Game.new #set up game conditions
    player1, player2 = game.get_players
    puts player1, player2
    while game.running
      [player1, player2].each do |player|
        move = player.get_move
        player.make_move(move)
        board.check
      end
    end
  end
end

main
