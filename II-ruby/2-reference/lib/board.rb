class Board
  # ALPHABET = a..z.to_a
  ALPHABET = Set.new("a".."z")

  def initialize(cards)
    @cards = cards
    @grid = Array.new(4) { Array.new(4) }
    # board.populate
  end

  def self.testable
    return grid(card1, card2)
  end

  # should fill the board with a set of shuffled Card pairs
  def populate
    card_values = ALPHABET.sample(8)
    @grid.each_with_index do |row, row_idx|
      row.each do |column, column_idx|
        @grid[row][column] = card_values[row_idx * 7 + column_idx]
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
