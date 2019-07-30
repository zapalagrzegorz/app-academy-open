require "byebug"

class Board
  attr_reader :size

  def self.print_grid(grid)
    grid.each do |row|
      #   row.each { |el| print "#{el} " }
      # each { |el| print "#{el} " }
      puts row.join(" ")
    end
  end

  def initialize(num)
    @grid = Array.new(num) { Array.new(num, :N) }
    @size = num * num
  end

  def [](position)
    row = position[0]
    column = position[1]
    @grid[row][column]
  end

  def []=(position, value)
    row, column = position
    # js [row, column] = position
    @grid[row][column] = value
  end

  def num_ships
    # sum = 0
    # @grid.each do |arr|
    #   sum += arr.count do |element|
    # element == :S
    #   end
    # end
    # sum
    @grid.flatten.count { |el| el == :S }
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      p "you sunk my battleship!"
      true
    else
      self[position] = :X
      false
    end
  end

  def place_random_ships
    numElements = size * 0.25
    # counter = 0
    arrLength = @grid[0].length
    # debugger
    until numElements <= num_ships
      randomRow = rand(0...arrLength)
      randomColumn = rand(0...arrLength)
      if self[[randomRow, randomColumn]] != :S
        self[[randomRow, randomColumn]] = :S
        # counter += 1
      end
    end
  end

  def hidden_ships_grid
    @grid.map do |arr|
      arr.map do |el|
        if el == :S
          :N
        else
          el
        end
      end
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(self.hidden_ships_grid)
  end
end

# board = Board.new(4)
# board.place_random_ships
