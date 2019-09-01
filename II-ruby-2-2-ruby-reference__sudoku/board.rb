require_relative "tile"
require "byebug"

class Board
  attr_reader :grid

  # read a file
  # and parse it into a two-dimensional Array containing Tile instances.
  def self.from_file

    # https://stackoverflow.com/questions/1727217/file-open-open-and-io-foreach-in-ruby-what-is-the-difference

    board = get_board_from_file("./puzzles/sudoku1_almost.txt")

    self.new(board)

    # self.new()el_numel_num
  end

  def initialize(grid)
    @grid = grid
  end

  # A render method to display the current board state
  def render
    @grid.each_with_index do |row, row_index|
      puts ""

      row.each_with_index do |el, col_index|
        # debugger
        print el.to_s
        print " " if ((col_index + 1) % 3).zero?
      end

      puts "" if ((row_index + 1) % 3).zero?
    end

    puts ""
  end

  #   A method to update the value of a Tile at the given position
  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col].value = value
  end

  #   A solved? method to let us know if the game is over
  def solved?
    # You will want to know if each row, column, and
    # 3x3 square has been solved.
    # solved_rows? && solved_columns? && solved_squares?
    unless solved_rows?
      puts "not solved rows"
      return false
    end

    unless solved_columns?
      puts "not solved columns"
      return false
    end

    unless solved_squares?(0, 2) && solved_squares?(3, 5) && solved_squares?(6, 8)
      puts "not solved some square"
      return false
    end

    true
  end

  #   I used several helper methods here. You will want to know if each row, column, and 3x3 square has been solved.
  # HELPERS
  def self.get_board_from_file(file)
    tiles = []

    File.foreach(file) do |line|
      numbers = line.chomp.split("")

      row = numbers.map { |el| Tile.new(el.to_i) }

      tiles.push(row)
    end

    tiles
  end

  def size
    return @grid.size
  end

  def solved_rows?
    @grid.all? { |row| solved_set?(row) }
  end

  def solved_columns?
    @grid.transpose.all? { |row| solved_set?(row) }
  end

  def solved_set?(tiles)
    tiles_values = tiles.map(&:value)
    tiles_values.uniq.length == tiles_values.length && tiles_values.none?(&:zero?)
  end

  def solved_squares?(startColumn, endColumn)
    columns_range = [[0, 2], [3, 5], [6, 8]]

    columns_range.each do |range|
      startColumn, endColumn = range

      return false unless solved_squares_in_range?(startColumn, endColumn)
    end

    puts ""

    true
  end

  def square_3x3?(sudoku_square)
    sudoku_square.length == 9
  end

  def solved_squares_in_range?(startColumn, endColumn)
    arr = []
    (0...9).each do |index_row|
      (startColumn..endColumn).each do |index_col|
        arr.push(@grid[index_row][index_col])
      end

      if square_3x3?(arr)
        return false unless solved_set?(arr)

        arr = []
      end
    end

    true
  end
end
