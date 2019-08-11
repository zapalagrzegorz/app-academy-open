require "set"
require_relative "card"

class Board
  ALPHABET = ("a".."z").to_a
  BOARD_SIZE = 4

  attr_reader :grid

  def initialize()
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
    populate
    # @guessed = 0
  end

  def self.testable
    return self.new()
  end

  # should fill the board with a set of shuffled Card pairs
  def populate
    random_cards = generate_random_cards

    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |_column, column_idx|
        @grid[row_idx][column_idx] = random_cards.shift
      end
    end
  end

  #   should print out a representation of the Board's current state
  def render
    # first line
    puts "  0 1 2 3"
    # print_line
    line = ""
    @grid.each_with_index do |row, row_index|
      line = row_index.to_s
      row.each_with_index do |tile|
        line += " #{tile}"
      end
      puts line
    end
  end

  #    should return true if all cards have been revealed.
  def won?

    # all inside all?!
    @grid.all? { |row| row.all?(&:is_face_up) }

    # moim zdaniem lepsze by było trzymanie informacji w stanie
    # @guessed == (BOARD_SIZE ** 2) / 2
    # albo trzymać liczbę odgadnionych pól
    # albo za każdym razem liczyć całość
  end

  #   should reveal a Card at guessed_pos
  #  (unless it's already face-up, in which case the method should do nothing).
  # It should also return the value of the card it revealed (you'll see why later).
  def reveal(pos)
    # debugger
    picked_card = self[pos]
    unless picked_card.is_face_up
      picked_card.reveal
      return picked_card.to_s
    end
  end

  def [](pos)
    row, column = pos.split(",")
    # debugger
    @grid[row.to_i][column.to_i]
  end

  # no use
  def []=(pos, value)
  end

  # utilities
  def generate_random_cards
    random_card_values = ALPHABET.sample(8)
    random_card_values += random_card_values
    random_card_values.shuffle
    random_card_values.map { |rand_value| Card.new(rand_value) }
  end
end
