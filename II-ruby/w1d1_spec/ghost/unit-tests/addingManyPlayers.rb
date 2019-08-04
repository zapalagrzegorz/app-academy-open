require_relative "../game"

Game.set_players

game = Game.new

if game.losses.keys.length == players_num
  puts "Stwrzony hash licznik punktów dla wybranej liczby graczy"
else
  puts "!Hash - licznik punktów dla wybranej liczby graczy wskazuje na inną liczbę graczy"
end
