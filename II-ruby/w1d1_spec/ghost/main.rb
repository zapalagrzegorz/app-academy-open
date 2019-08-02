require_relative "game"

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  while game.play_round
  end

  puts "Ghost of the game is #{game.current_player.name}"
end
