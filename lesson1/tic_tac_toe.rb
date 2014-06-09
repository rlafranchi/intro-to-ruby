# tic tac toe program
# 1. Come up with requirements/specidications, which will determine scope
# 2. Application logic: sequence steps
# 3. Translation of those steps into code
# 4. Run code to verify logic

# require 'pry'

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
  
  # check whether entry is valid
  while b[position] != ' '
    puts "Invalid Entry.. Please pick a position that is an integer between 1 and 9 and has not been played"
    position = gets.chomp.to_i
  end
  
  b[position] = 'X'
end

def computer_picks_square(b)
  position = empty_positions(b).sample
  b[position] = 'O'
  puts "computer picks position #{position}"
end

def check_winner(b)
  winners = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  i = 0
  
  while i <= 7
    if ( b[winners[i][0]].to_s == 'X' ) && ( b[winners[i][1]].to_s == 'X' ) && ( b[winners[i][2]].to_s == 'X' )
      return 'You Win'
    elsif ( b[winners[i][0]].to_s == 'O' ) && ( b[winners[i][1]].to_s == 'O' ) && ( b[winners[i][2]].to_s == 'O' )
      return 'You Lose'
    else
      i += 1
    end
  end
  return false # will get to this point if no winner
end

board = initialize_board
draw_board(board)

begin
  player_picks_square(board)
  computer_picks_square(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner
  puts "#{winner}"
else
  puts "It's a tie!"
end