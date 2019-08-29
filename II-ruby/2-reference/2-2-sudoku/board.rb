require_relative "tile"
require "byebug"

class Board
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file

    # https://stackoverflow.com/questions/1727217/file-open-open-and-io-foreach-in-ruby-what-is-the-difference

    board = get_board_from_file("./puzzles/sudoku1.txt")

    self.new(board)
    # read a file
    # and parse it into a two-dimensional Array containing Tile instances.

    # self.new()el_numel_num
  end

  def self.get_board_from_file(file)
    board = []

    File.foreach(file) do |line|
      # debugger
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

  def render
    @grid.each do |row|
      puts ""
      row.each { |el| print el.to_s }
    end
    puts ""
  end

  #   A method to update the value of a Tile at the given position

  # A render method to display the current board state

  #   A solved? method to let us know if the game is over

  #   I used several helper methods here. You will want to know if each row, column, and 3x3 square has been solved.
end

board = Board.from_file
board.render
