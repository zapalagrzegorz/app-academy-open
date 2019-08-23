require_relative "card"

class Board
  ALPHABET = ("a".."z").to_a
  BOARD_SIZE = 4

  # testing purposes
  attr_accessor :grid

  # attr_reader :grid

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
    random_cards = Card.generate_random_cards(BOARD_SIZE, ALPHABET)

    @grid.each_with_index do |row, row_idx|
      row.each_index do |column_idx|
        @grid[row_idx][column_idx] = random_cards.shift
      end
    end
  end

  #   should print out a representation of the Board's current state
  def render
    # first line
    puts "  0 1 2 3"
    # puts "  #{(0...size).to_a.join(' ')}"
    # print_line
    line = ""
    @grid.each_with_index do |row, row_index|
      line = row_index.to_s
      row.each do |tile|
        line += " #{tile}"
      end
      # puts "#{i} #{row.join(' ')}"
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
  # w solucji to metoda statyczna Card
  # i to ma sens! bo chodzi o card, a nie o board

  def get_unknown_tiles
    # pos => value
    unknown_tiles = {}
    @grid.each_with_index do |row, row_idx|
      row.each_with_index do |tile, column_idx|
        unless tile.is_face_up
          pos_key = "#{row_idx},#{column_idx}"
          # debugger
          unknown_tiles[pos_key] = tile.value
        end
      end
    end

    unknown_tiles
  end
end
