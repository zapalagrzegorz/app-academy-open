require_relative "board"
require_relative "card"
# require "set"
require "byebug"

class Memory_Puzzle

  # tests only
  attr_accessor :guessed, :board

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

  def check_match?
    # tu muszę porównać wartości
    # debugger
    if @board[@guessed[0]] == @board[@guessed[1]]
      puts "Made a match!"
      true
    else
    end
  end

  # debug purposes
  # private

  def play_round
    system("clear")

    board.render

    until player_picked_two?
      take_turn
    end

    if check_match?
      record_match
    else
      hide_tiles_and_prompt_user
    end
    # check
    sleep(n)
  end

  # HELPERS
  def take_turn
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
    # debugger
    @board.reveal(valid_input)
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

  def record_match
    # found tiles set to revealed
    @board[@guessed[0]].reveal
    @board[@guessed[1]].reveal
  end

  def hide_tiles_and_prompt_user
    puts "Keep gueesing"
    @board[@guessed[0]].hide
    @board[@guessed[1]].hide
  end
end
