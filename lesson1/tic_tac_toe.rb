# tic tac toe program
# 1. Come up with requirements/specidications, which will determine scope
# 2. Application logic: sequence steps
# 3. Translation of those steps into code
# 4. Run code to verify logic

require 'pry'

# psuedo code
# draw a board

# assign player1 to "O"
# assign player2 to "X"
#
# repeat until one player gets three in a row, column, diagonaly or tie
#   player picks an empty square
#   check for winner
#   computer picks an empty square
#   check for winner
#    
# if there's a winner
#   show winner
# else
#   Tie
def initialize_board
  b = {}
  (1..9).each {|position| b[position] = ' '}
  b
end

def draw_board(b)
  puts "-------------"
  puts "| #{b[1]} | #{b[2]} | #{b[3]} |"
  puts "-------------"
  puts "| #{b[4]} | #{b[5]} | #{b[6]} |"
  puts "-------------"
  puts "| #{b[7]} | #{b[8]} | #{b[9]} |"
  puts "-------------"
end

def empty_positions(b)
  b.select {|k, v| v == ' '}.keys
end

def player_picks_square(b)
  puts "Pick a square (1-9):"
  position = gets.chomp.to_i
  b[position] = 'X'
  binding.pry
end

def computer_picks_square(b)
  position = empty_positions(b).sample
  b[postion] = 'O'
end

board = initialize_board

draw_board(board)
player_picks_square(board)
draw_board(board)

begin
  
end until winner || all_squares_taken?