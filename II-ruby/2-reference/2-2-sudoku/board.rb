require_relative "tile"

class Board
  def initialize(grid)
    @grid = grid
  end

  def self.from_file
    # if File.exist?("dictionary.txt")
    board = []

    File.foreach("./puzzles/sudoku1.txt") do |line|
      # debugger
      row = []
      line.split("").each do |el|
        el_num = el.to_i
        if el_num.zero?
          row.push(Tile.new(el_num))
        else
          row.push(Tile.new(el_num, true))
        end

        # puts gridLine
        board.push(row)
      end
      # @dictionary.add(line.chomp)
      # end
    end
    puts board
    # read a file
    # and parse it into a two-dimensional Array containing Tile instances.

    # self.new()
  end

  #   A method to update the value of a Tile at the given position

  # A render method to display the current board state

  #   A solved? method to let us know if the game is over

  #   I used several helper methods here. You will want to know if each row, column, and 3x3 square has been solved.
end
