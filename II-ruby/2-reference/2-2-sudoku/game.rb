class Game
  def initialize
    @board
  end

  def play
  end

  def solved
    @board.solved?
  end

  def render
  end

  def prompt
  end

  def valid_play?
  end

  def set_tile
    @board[pos] = value
  end

  #   render the board,
  #   prompt the player for input,
  #   and then get both a pos and a value from the player.
  #   It should then update the tile at pos with the new value.
  #   I wrote helper methods to get and validate input from the user;
  #   this should help keep our program from crashing. :)

end
