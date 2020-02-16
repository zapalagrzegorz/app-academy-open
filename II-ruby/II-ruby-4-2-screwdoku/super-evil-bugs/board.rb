require_relative "tile"
require "byebug"

class Board
  attr_reader :grid

  def self.empty_grid
    @grid = Array.new(9) do
      Array.new(9) { Tile.new(0) }
    end
    grid
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split("").map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid = self.empty_grid)
    @grid = grid
  end

  def [](pos)
    # debugger
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end

  def columns
    rows.transpose
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}"
    grid.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end

  def size
    grid.size
  end

  alias_method :rows, :grid

  def solved?
    rowsSolved = rows.all? { |row| solved_set?(row) }
    #  &&
    columnsSolved = columns.all? { |col| solved_set?(col) }
    #  &&
    squaresSolved = squares.all? do |square|
      # debugger
      solved_set?(square)
    end

    return true if rowsSolved && columnsSolved && squaresSolved

    false
  end

  def solved_set?(tiles)
    nums = tiles.map(&:value)
    nums.sort == (1..9).to_a
  end

  def square(idx)
    tiles = []
    x = (idx / 3) * 3
    y = (idx % 3) * 3
    # debugger
    (x...x + 3).each do |i|
      (y...y + 3).each do |j|
        tiles << self[[i, j]]
      end
    end

    tiles
  end

  def squares
    squares = []
    (0..8).to_a.each do |i|
      # debugger if i == 0
      squares << square(i)
    end

    squares
  end
end
