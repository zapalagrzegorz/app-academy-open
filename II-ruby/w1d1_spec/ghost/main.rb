require_relative "game"

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  game.run

  puts "Winner of the game is #{game.players[0].name}"
end
