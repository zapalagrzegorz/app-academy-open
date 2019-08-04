require_relative "game"

game = Game.new
# game.losses[game.current_player] = 2

game.fragment = "aba"

debugger
if game.valid_play?("c") == true
  puts "OK"
else
  puts "NOT CORRECT"
end

if game.valid_play?("a") == false
  puts "OK"
else
  puts "NOT CORRECT"
end
