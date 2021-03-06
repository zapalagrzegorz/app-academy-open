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

def hide_all_cards(test_board)
  test_board.grid.each_with_index do |row, row_idx|
    row.each_with_index do |_column, column_idx|
      test_board.grid[row_idx][column_idx].hide
    end
  end
end

hide_all_cards(test_board)

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
# debugger
ai_first_guess = memory_puzzle.ai_player.make_guess(uknown_tiles)
if ai_first_guess.respond_to?(:to_s)
  # debugger
  puts "OK" if memory_puzzle.valid_play?(ai_first_guess)
else
  puts "Fails to make a correct guess".red
  return
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

# debugger
AIplayer_known_card_key, AIplayer_known_card_val = memory_puzzle.ai_player.known_cards.first

if AIplayer_known_card_key.respond_to?(:to_s) &&
   AIplayer_known_card_key.length == 3 &&
   AIplayer_known_card_val.length == 1
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

puts "#second AI guess"

# debugger

uknown_tiles_after_first_guess = test_board.get_unknown_tiles
ai_second_guess = memory_puzzle.ai_player.make_guess(uknown_tiles_after_first_guess)
if ai_second_guess != ai_first_guess
  puts "OK"
else
  puts "Fails to make a correct second guess. Second guess is equal to first".red
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
# debugger

hide_all_cards(test_board)

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

puts "## AI PLAYER find matches"

memory_puzzle.ai_player.known_cards = {
  "0,0" => "a",
  "0,1" => "b",
  "0,2" => "c",
}
# debugger
memory_puzzle.ai_player.matching_pair = []

unless memory_puzzle.ai_player.match?
  puts "OK"
else
  puts "AI Player finds a match where it isn't".red
  return
end

memory_puzzle.ai_player.known_cards = {
  "0,0" => "a",
  "0,1" => "b",
  "0,2" => "a",
}
memory_puzzle.ai_player.set_matching_cards
# debugger
if memory_puzzle.ai_player.match?
  puts "OK"
else
  puts "AI Player fails to finds a match".red
  return
end

puts "## AI PLAYER makes a pick of unknown tile"

memory_puzzle.ai_player.matching_pair = []
# clear #reveal
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    test_board.grid[row_idx][column_idx].hide
  end
end

memory_puzzle.ai_player.known_cards = {
  "0,0" => "c",
  "0,1" => "b",
}
knownPositions = ["0,0", "0,1"]
# all cards are hidden

AIGuess = memory_puzzle.ai_player.make_guess(uknown_tiles)

# debugger
unless knownPositions.include?(AIGuess)
  puts "OK"
else
  puts "AI Player fails to pick random tile".red
  return
end

memory_puzzle.ai_player.matching_pair = []

test_board.grid[0][0] = Card.new("c")
test_board.grid[0][1] = Card.new("b")
test_board.grid[0][2] = Card.new("d")
test_board.grid[0][2].reveal
test_board.grid[0][3] = Card.new("d")

uknown_tiles = test_board.get_unknown_tiles

AIGuessFirst = memory_puzzle.ai_player.make_guess(uknown_tiles)

puts "## AI PLAYER make random first guess, and pairs it with memory"

# clear #reveal
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    test_board.grid[row_idx][column_idx].hide
  end
end

memory_puzzle.ai_player.known_cards = {
  "0,0" => "c",
  "0,1" => "b",
  "0,2" => "d",
}

memory_puzzle.ai_player.matching_pair = []

test_board.grid[0][0] = Card.new("c")
test_board.grid[0][1] = Card.new("b")
test_board.grid[0][2] = Card.new("d")
test_board.grid[0][2].reveal
test_board.grid[0][3] = Card.new("d")

uknown_tiles = test_board.get_unknown_tiles
known_cards = ["0,0", "0,1", "0,2"]
# knon
# debugger
AIGuessSecond = memory_puzzle.ai_player.make_guess(uknown_tiles)

if !known_cards.include?(AIGuessSecond)
  puts "OK"
else
  puts "AI Player fails to pick unknown tile".red
  return
end

# clear #reveal
test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    test_board.grid[row_idx][column_idx].hide
  end
end

puts "## AIplayer update_matching_cards"

memory_puzzle.ai_player.matching_pair = ["0,0", "0,1"]
all_posibilities = []

test_board.grid.each_with_index do |row, row_idx|
  row.each_with_index do |_column, column_idx|
    all_posibilities.push("#{row_idx},#{column_idx}")
  end
end

all_possibilites = all_posibilities - memory_puzzle.ai_player.matching_pair

if all_possibilites.length == 14
  puts "OK"
else
  puts "failure with update_matching_cards".red
  return
end

# zaczął brać ciągle kartę już odkrytą
# Card is already revealed

# hide_all_cards
puts "### scoring"

puts "## AIplayer has score attribute initialized"

if memory_puzzle.ai_player.score == 0
  puts "OK"
else
  puts "AIplayer fails to initialize score attribute".red
  return
end

puts "## AIplayer records positive match"

memory_puzzle.ai_player.record_score

if memory_puzzle.ai_player.score == 1
  puts "OK"
else
  puts "AIplayer fails to initialize score attribute".red
  return
end

puts "## Human Player has score attribute initialized"

if human_player.score == 0
  puts "OK"
else
  puts "Human Player fails to initialize score attribute".red
  return
end

puts "## Human Player records positive match"

human_player.record_score

if human_player.score == 1
  puts "OK"
else
  puts "human_player fails to initialize score attribute".red
  return
end
