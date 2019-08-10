require_relative "board"
require_relative "memory_puzzle"
require "byebug"

# require_relative ""
ALPHABET = [("a".."z")]
test_board = Board.testable

# CARD

puts "it generates card"

puts "cards of equal value are equal"
card1 = Card.new("a")
card2 = Card.new("b")
card3 = Card.new("a")

if card1 == card3
  puts "OK"
else
  "FAILURE"
end

if card1 != card2
  puts "OK"
else
  "FAILURE"
end

test_board.populate
# debugger

puts "it populates test_board"

card = test_board.grid[0][0]

if card.instance_of? Card
  puts "it populates board with Cards"
else
  puts "it fails to populate board with Cards"
end

puts "it populates test_board with pairs of Cards"

pair = 0
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    if test_board.grid[row_idx][column_idx] == card
      pair += 1
    end
  end
end

if pair == 2
  puts "it populates board with a pair of char"
else
  puts "it fails to populate board with a pair of char"
end

# game.losses[game.current_player] = 2

test_board.render
# puts board

puts "it MEMORY PUZZLE"
#
puts "it creates memory puzzle"

memory_puzzle = Memory_Puzzle.new(test_board)

if memory_puzzle
  puts "OK"
else
  puts "FAILURE"
end

puts "memory_puzzle takes a player pick"

#validate input

if memory_puzzle.valid_play?("0,0")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input"
end

unless memory_puzzle.valid_play?("5,0")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input"
end

unless memory_puzzle.valid_play?("a")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input"
end

memory_puzzle.guessed[0] = "0,0"
unless memory_puzzle.valid_play?("0,0")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input - 
  the same input should be invalid"
end
# memory_puzzle.take_turn

if memory_puzzle.guessed.length == 1
  "OK"
else
  "FAILURE"
end

memory_puzzle.guessed[1] = "0,1"

if memory_puzzle.player_picked_two?
  puts "OK"
else
  puts "Player_picked_two? failed. Should return true, when there're
   two correct guess"
end
# memory_puzzle
