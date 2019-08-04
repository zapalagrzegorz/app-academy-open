# if losses[@previous_player.name] == 2
# return false
require_relative "../game"

# Game.setPlayers
new_player_gelo = Player.new("Gelo")
new_player_kylo = Player.new("Kylo")
new_player_robcio = Player.new("Robcio")

Game.add_player(new_player_gelo)
Game.add_player(new_player_kylo)
Game.add_player(new_player_robcio)

game_check_eleminate = Game.new

# ustalć poprzedniego gracza
# debugger
game_check_eleminate.previous_player = game_check_eleminate.players[0]
prev_player = game_check_eleminate.previous_player
game_check_eleminate.losses[prev_player] = 2

game_check_eleminate.check_and_eleminate_loser

if game_check_eleminate.players.length == 2
  puts "OK"
else
  puts "game_check_eleminate doesnt work correctly"
  # next_player
end
