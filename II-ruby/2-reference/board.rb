require "set"

class Board
  ALPHABET = [("a".."z")]

  attr_reader :grid

  def initialize(cards)
    @cards = cards
    @grid = Array.new(4) { Array.new(4) }
    # board.populate
  end

  def self.testable
    return self.new(["card1", "card2"])
  end

  # should fill the board with a set of shuffled Card pairs
  def populate
    card_values = ALPHABET.sample(8)
    card_values += card_values
    # p card_values
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |column, column_idx|
        @grid[row_idx][column_idx] = card_values[row_idx * 4 + column_idx]
      end
    end
  end

  #   should print out a representation of the Board's current state
  def render
  end

  #    should return true if all cards have been revealed.
  def won?
  end

  #   should reveal a Card at guessed_pos
  #  (unless it's already face-up, in which case the method should do nothing). It should also return the value of the card it revealed (you'll see why later).
  def reveal
  end

  def [](pos)
  end

  def []=(pos, value)
  end
end
