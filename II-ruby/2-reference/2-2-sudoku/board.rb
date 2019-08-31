require_relative "tile"
require "byebug"

class Board
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file

    # https://stackoverflow.com/questions/1727217/file-open-open-and-io-foreach-in-ruby-what-is-the-difference

    board = get_board_from_file("./puzzles/sudoku1_almost.txt")

    self.new(board)
    # read a file
    # and parse it into a two-dimensional Array containing Tile instances.

    # self.new()el_numel_num
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
  def []=(pos, value)
    row, col = pos
    @grid[row][col].value = value
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  #   A solved? method to let us know if the game is over
  def solved?
    # You will want to know if each row, column, and
    # 3x3 square has been solved.
    # solved_rows? && solved_columns? && solved_squares?
    # return
    debugger
    unless solved_rows?
      puts "not solved rows"
      return false
    end

    unless solved_columns?
      puts "not solved columns"
      return false
    end

    unless solved_squares?
      return false
    end

    puts "solved"

    true
  end

  #   I used several helper methods here. You will want to know if each row, column, and 3x3 square has been solved.
  # HELPERS
  def self.get_board_from_file(file)
    board = []

    File.foreach(file) do |line|
      row = []
      line.chomp.split("").each do |el|
        el_num = el.to_i
        if el_num.zero?
          row.push(Tile.new(el_num))
        else
          row.push(Tile.new(el_num, true))
        end
      end
      board.push(row)
    end

    board
  end

  def size
    return @grid.size
  end

  def solved_rows?
    @grid.each do |row|
      arr = []
      row.each do |tile|
        arr.push(tile.value)
      end

      return false unless arr.none?(&:zero?) && arr.uniq.length == arr.length
    end
  end

  def solved_columns?
    @grid.transpose.all? { |row| row.uniq.length == row.length }
  end

  def solved_squares?
    arr = []

    (0...9).each do |index_row|
      (0..2).each do |index_col|
        arr.push(@grid[index_row][index_col].value)
      end
      if ((index_row + 1) % 3).zero?
        return false unless arr.uniq.length == arr.length

        arr = []
      end
    end

    puts ""

    (0...9).each do |index_row|
      (3..5).each do |index_col|
        arr.push(@grid[index_row][index_col].value)
      end
      if (((index_row + 1) % 3).zero?)
        return false unless arr.uniq.length == arr.length

        arr = []
      end
    end

    puts ""

    (0...9).each do |index_row|
      (6...9).each do |index_col|
        arr.push(@grid[index_row][index_col].value)
      end
      if ((index_row + 1) % 3).zero?
        return false unless arr.uniq.length == arr.length

        arr = []
      end
    end

    # @grid.each_with_index do |row, row_index|
    #   # row - [0,1,2]
    #   arr = []

    #   row.each_with_index do |row_el, el_index|
    #     if (((el_index + 1) % 3).zero?)
    #     end
    #     # row_el - 0, 1, 2
    #     # stąd bym chciał tylko jedną tablicę
    #     # columns.each do |column|
    #     # [0,1,2]
    #     # column.each do |column_el|
    #     # 0,1,2
    #     # debugger
    #     arr.push(@grid[row_el][column_el].value)
    #     # end
    #   end
    #   arr = []
    #   # end
    #   print arr
    # end

    # @grid[0][0]
    # @grid[1][0]
    # @grid[2][0]

    # @grid[0][1]
    # @grid[1][1]
    # @grid[2][1]

    # @grid[0][2]
    # @grid[1][2]
    # @grid[2][2]

    # # 2
    # @grid[0][3]
    # @grid[0][4]
    # @grid[0][5]

    # @grid[1][3]
    # @grid[1][4]
    # @grid[1][5]

    # @grid[2][3]
    # @grid[2][4]
    # @grid[2][5]
    # 3..5
    # 0..2

    # 6..8
    # 0..2

    # 0..2
    # 3..5

    # 0..2
    # 6..8
  end
end
