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
#
# X   X
#  X X
#   X
#  X X
# X   X
#
#  XXX
# X   X
# X   X
# X   X
#  XXX
#

class Board
  attr_accessor :board, :blank, :x, :o

  def initialize
    @blank = ['     ','     ','     ','     ','     ']
    @x     = ['X   X',' X X ','  X  ',' X X ','X   X']
    @o     = [' XXX ','X   X','X   X','X   X',' XXX ']
    @board = {one: x,
              two: blank,
              three: o,
              four: blank,
              five: blank,
              six: blank,
              seven: blank,
              eight: blank,
              nine: blank,
             }
  end

  def draw_board
    (0..4).each do |line|
      puts " #{board[:one][line]} | #{board[:two][line]} | #{board[:three][line]} "
    end
    puts "======================="
    (0..4).each do |line|
      puts " #{board[:four][line]} | #{board[:five][line]} | #{board[:six][line]} "
    end
    puts "======================="
    (0..4).each do |line|
      puts " #{board[:seven][line]} | #{board[:eight][line]} | #{board[:nine][line]} "
    end
  end

  def make_move(move)
  end
end

Board.new.draw_board






