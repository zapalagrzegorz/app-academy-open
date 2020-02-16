require_relative "../game"

game = Game.testable
#
# game.losses[game.current_player] = 2

game.fragment = "aba"

# debugger
if game.valid_play?("c") == true
  puts "OK validates moves - [word exist]"
else
  puts "NOT CORRECT - doesn't allow for the suitable char"
end

# debugger
if game.valid_play?("a") == false
  puts "OK validates moves -  - [word doesn't exist]"
else
  puts "NOT CORRECT - allows for disallowed char"
end

# puts "dictionary initializes"
unless game.dictionary.empty?
  puts "OK dictionary initializes - "
else
  puts "NOT CORRECT dictionary initializes"
end

game.fragment = "abaci"

if game.word_completed?
  puts "OK"
else
  puts "NOT CORRECT - word should be found in dict "
end
