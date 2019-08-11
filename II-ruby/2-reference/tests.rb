require_relative "board"
require_relative "memory_puzzle"
require_relative "human-player"
require "byebug"
require "colorize"

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

#
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

# # BOARD
puts "helper board[pos] checks board grid[row][column]?"

# debugger
if test_board["0,0"].instance_of? Card
  puts "OK"
else
  puts "board[pos] fails to find instance of Card at @board[0,0]"
  return
end

if pair == 2
  puts "it populates board with a pair of char"
else
  puts "it fails to populate board with a pair of char".red
  return
end

# game.losses[game.current_player] = 2

test_board.render
# puts board

puts "it won? returns true when every card is revealed"

test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    test_board.grid[row_idx][column_idx].reveal
  end
end

if test_board.won?
  puts "OK"
else
  puts "test_board.won? fails".red
  return
end

# clear #reveal
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    test_board.grid[row_idx][column_idx].hide
  end
end

puts "## board get_unknown_tiles"

uknown_tiles = test_board.get_unknown_tiles
# debugger
if uknown_tiles.length == 16
  puts "OK"
else
  puts "#get_unknown_tiles fails to return array of uknown tiles(cards)".red
  return
end

puts "###describe MEMORY PUZZLE"
#
puts "##it creates memory puzzle"

# debugger
memory_puzzle = Memory_Puzzle.new(test_board)

if memory_puzzle
  puts "OK"
else
  puts "FAILURE".red
  return
end

puts "## memory puzzle includes @humanPlayer"

human_player = HumanPlayer.new

if human_player
  puts "OK"
else
  puts "Human Player doesn't exist".red
  return
end

if memory_puzzle.human_player
  "OK"
else
  puts "human player is not a member of memory_puzzle".red
  return
end

puts "## memory puzzle includes @AIplayer"

if memory_puzzle.ai_player
  puts "OK"
else
  puts "ai_player is not a member of memory_puzzle".red
  return
end

puts "##memory_puzzle takes a AI player pick"

puts "#AI player makes guess"
ai_first_guess = memory_puzzle.ai_player.make_guess(uknown_tiles)
if ai_first_guess == "0,0"
  puts "OK"
else
  puts "Fails to make a correct guess".red
end

puts "#ai makes valid guess"
if memory_puzzle.valid_play?(ai_first_guess)
  puts "OK"
else
  puts "failes".red
  return
end

puts "#update_and_render_board for AI move"

memory_puzzle.update_and_render_board(ai_first_guess)

if memory_puzzle.guessed.length == 1
  puts "OK"
else
  puts "Game should have recorded AI guess".red
  return
end

puts "#AI player should record its known_cards"

if memory_puzzle.ai_player.known_cards.length == 1
  puts "OK"
else
  puts "nothing is recorded in known cards".red
  return
end

AIplayer_known_card_key, AIplayer_known_card_val = memory_puzzle.ai_player.known_cards.first

if AIplayer_known_card_key == "0,0"
  puts "OK"
else
  puts "wrong card recorded in known cards".red
  return
end

if AIplayer_known_card_val.length == 1
  puts "OK"
else
  puts "AIplayer_known_card_value should be char of 1 length".red
  return
end

puts "# game should record ai guess on board"
if memory_puzzle.board.get_unknown_tiles.length == 15
  puts "OK"
else
  puts "FAILURE".red
  return
end

puts "# second AI guess"

# debugger
uknown_tiles_after_first_guess = test_board.get_unknown_tiles
ai_second_guess = memory_puzzle.ai_player.make_guess(uknown_tiles_after_first_guess)
if ai_second_guess == "0,1"
  puts "OK"
else
  puts "Fails to make a correct guess".red
  return
end

puts "#ai makes valid guess"
if memory_puzzle.valid_play?(ai_second_guess)
  puts "OK"
else
  puts "failes to validate ai guess".red
  return
end

puts "##memory_puzzle takes a player pick"

# can't be anymore (0,0), as it's taken above, as well as 0,1
# no after each, before_each methods
if memory_puzzle.valid_play?("0,2")
  puts "OK"
else
  puts "human_player fails to validate correct player input".red
  return
end

unless memory_puzzle.valid_play?("5,0")
  puts "OK"
else
  puts "human_player fails to validate player input - outside range".red
  return
end

unless memory_puzzle.valid_play?("a")
  puts "OK"
else
  puts "human_player fails to validate player input - incorrect format".red
  return
end

memory_puzzle.guessed[0] = "0,0"
memory_puzzle.board.reveal(memory_puzzle.guessed[0])

unless memory_puzzle.valid_play?("0,0")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input - 
  the same input should be invalid".red
  return
end
# memory_puzzle.take_turn

if memory_puzzle.guessed.length == 1
  "OK"
else
  "FAILURE - picked tile is not in guessed tiles list".red
  return
end

memory_puzzle.board.reveal("0,3")

unless memory_puzzle.valid_play?("0,3")
  puts "OK"
else
  puts "memory_puzzle fails to validate player input - 
  revealed card should be invalid".red
  return
end

# debugger
memory_puzzle.board.reveal(memory_puzzle.guessed[0])
if memory_puzzle.board[memory_puzzle.guessed[0]].is_face_up
  puts "OK"
else
  puts "FAILURE - Guessed tile is not revealed".red
  return
end

memory_puzzle.guessed[1] = "0,1"

if memory_puzzle.player_picked_two?
  puts "OK"
else
  puts "Player_picked_two? failed. Should return true, when there're
   two correct guess".red
  return
end

puts "Checks a match"
# debugger

card = test_board.grid[0][0]
memory_puzzle.guessed[0] = "0,0"
# find a pair

pairing_indices = ""
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    if test_board["#{row_idx}, #{column_idx}"] == card
      pairing_indices = "#{row_idx},#{column_idx}"
    end
  end
end

memory_puzzle.guessed[1] = pairing_indices

if memory_puzzle.check_match?
  puts "OK"
else
  puts "check_match? fails to find a match".red
  return
end

# memory_puzzle
# testy ręczne całości, aby ustalić, które elementy dalej
# ostatnio była kończona metoda won?

# colorize matches
# should be able to choose revelead card
# completed
