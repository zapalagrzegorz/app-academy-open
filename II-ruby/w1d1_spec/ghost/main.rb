require_relative "game"

if __FILE__ == $PROGRAM_NAME
  Game.set_players

  game = Game.new

  while game.run
    puts "__________________________"
    puts
  end

  puts "Winner of the game is #{game.players[0].name}"
end
