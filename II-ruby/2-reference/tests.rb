require_relative "board"

# require_relative ""
ALPHABET = Set.new("a".."z")
test_board = Board.testable

test_board.populate

puts "it populates test_board"

# p test_board.grid
char = test_board.grid[0][0]
# p test_board[0]

if ALPHABET.include?(char)
  puts "it populates board with alphabet char"
else
  puts "it fails to populate boar with a char"
end

pair = 0
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    if test_board.grid[row_idx][column_idx] == char
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
