require_relative "board"
require_relative "card"
# require "set"
require "byebug"

class MemoryPuzzle
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
    puts "Current text is: #{@fragment}"

    until valid_input
      player_char = @current_player.guess
      valid_input = valid_play?(player_char)
      unless valid_input
        @current_player.alert_invalid_guess
      end
    end

    @fragment += player_char
  end
end
