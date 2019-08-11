require_relative "memory_puzzle"

if __FILE__ == $PROGRAM_NAME
  game = Memory_Puzzle.new(Board.new)

  game.run

  game.completed
end
