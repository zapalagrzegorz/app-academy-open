require_relative "board"
require_relative "card"
require_relative "human-player"
require_relative "AI-player"
# require "set"
require "byebug"

class Memory_Puzzle

  # tests only
  attr_accessor :guessed, :board, :human_player, :ai_player
  # human_player

  # attr_reader :guessed

  def initialize(board)
    @board = board
    @guessed = []
    @human_player = HumanPlayer.new
    @ai_player = AIplayer.new
    @current_player = @human_player
  end

  def run
    until @board.won?
      play_round
    end
  end

  def check_match?
    if @board[@guessed[0]] == @board[@guessed[1]]
      puts "Made a match!"
      true
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
      clear_tiles
    end

    change_player
    # check
    sleep(2)
  end

  # HELPERS
  def take_turn
    puts ""
    valid_input = nil
    until valid_input
      possible_guesses = @board.get_unknown_tiles
      valid_input = @current_player.make_guess(possible_guesses, @guessed[0])
      unless valid_play?(valid_input)
        valid_input = nil
      end
    end

    update_and_render_board(valid_input)
    sleep(2)
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
    clear_guessed
  end

  def clear_tiles
    puts "Keep gueesing"
    @board[@guessed[0]].hide
    @board[@guessed[1]].hide
    clear_guessed
  end

  def clear_guessed
    @guessed = []
  end

  def update_and_render_board(player_guess)
    @guessed.push(player_guess)
    @board.reveal(player_guess)
    @board.render
  end

  def valid_play?(player_input)
    unless /^[0-3],[0-3]$/ =~ player_input
      puts "Accepted format is [0-3],[0-3]"
      return false
    end

    if @board[player_input].is_face_up
      puts "Card is already revealed"
      return false
    end

    true
  end

  def completed
    puts
    puts "Game completed!"
  end

  def change_player
    if @current_player == @human_player
      @current_player = @ai_player
    else
      @current_player = @human_player
    end

    puts "Now its turn for #{@current_player}"
  end
end
