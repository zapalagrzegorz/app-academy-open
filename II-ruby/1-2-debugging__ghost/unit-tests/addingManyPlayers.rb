require_relative "../game"

game = Game.new

# debugger
if game.losses.keys.length == game.players.length
  puts "Stwrzony licznik punktów dla wybranej liczby graczy"
else
  puts "!Hash - licznik punktów dla wybranej liczby graczy wskazuje na inną liczbę graczy"
end
