# PROMPT now

require_relative "board"

class Game
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      set_tile(get_player_input)
    end

    puts "Congratulations, you win!"
  end

  def solved?
    @board.solved?
  end

  def render
    @board.render
  end

  # PLAYER INPUT
  def prompt_pos
    puts "Please enter the position of the sudoku you'd like to place value (e.g., '2,3')"
    print "> "
  end

  def prompt_value
    puts "Please enter the value"
    print "> "
  end

  def get_player_input
    pos = nil
    value = nil

    until pos && valid_pos?(pos)
      pos = get_input_pos
    end

    until value && valid_value?(value)
      value = get_input_value[0]
    end

    return [pos, value]
  end

  def get_input_pos
    prompt_pos
    parse(STDIN.gets.chomp)
  end

  def get_input_value
    prompt_value
    parse(STDIN.gets.chomp)
  end

  def parse(string)
    # https://stackoverflow.com/questions/49274/safe-integer-parsing-in-ruby
    string.split(",").map { |i| i.to_i if i.match(/\A\d+\Z/) }
  end

  def valid_pos?(pos)
    unless pos.is_a?(Array) && pos.count == 2 &&
           pos.all? { |x| x.between?(0, @board.size - 1) }
      puts "Invalid position."

      return false
    end

    if @board[pos].given == true
      puts "You can't change value of given elements"

      return false
    end

    true
  end

  def valid_value?(value)
    value.between?(0, @board.size - 1)
  end

  # PLAY
  def set_tile(player_input)
    # debugger
    pos, value = player_input
    @board[pos] = value
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new(Board.from_file).play
end

game = Game.new(Board.from_file)
game.board.solved?
