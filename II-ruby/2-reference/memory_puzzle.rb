require_relative "board"
require_relative "card"
# require "set"
require "byebug"

class Memory_Puzzle

  # tests only
  attr_accessor :guessed

  # attr_reader :guessed

  def initialize(board)
    @board = board
    @guessed = []
  end

  def run
    until @board.won?
      play_round
    end
  end

  def check_match
    # @guessed[0] == guessed[1]
  end

  # debug purposes
  # private

  def play_round
    system("clear")

    board.render

    until player_picked_two?
      take_turn
    end

    check_match
    # check
    sleep(n)
  end

  # HELPERS
  def take_turn
    valid_input = false
    puts ""

    valid_input = false
    until valid_input
      puts "Make a pick of a tile: "
      valid_input = valid_play?(gets.chomp)
      # expected formatrow, column
      # player_char = @current_player.guess
      # valid_input = valid_play?(player_char)
      unless valid_input
        alert_invalid_guess
      end
    end

    guessed.push(valid_input)
  end

  def valid_play?(player_input)
    unless /^[0-3],[0-3]$/ =~ player_input
      return false
    end

    # debugger
    if player_input == @guessed[0]
      return false
    end

    true
  end

  def alert_invalid_guess
    puts "Accepted format is [0-3],[0-3]"
  end

  def player_picked_two?
    @guessed.length == 2
  end
end
