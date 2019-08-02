require_relative "player"
require "byebug"

class Game
  # attr_accessor :current_player, :previous_player

  def initialize
    @fragment = ""
    @current_player = Player.new("Gelo")
    @previous_player = Player.new("Krzycho")
    @dictionary = Hash.new()
  end

  def dictionary
    if @dictionary.length == 0
      @dictionary = setDictionary
    else
      @dictionary
    end
  end

  def setDictionary
    dict = Hash.new
    if File.exist?("dictionary.txt")
      # debugger
      File.foreach("dictionary.txt") do |line|
        dict[line.chomp] = true
      end
    end

    dict
  end

  def play_round
    take_turn(current_player)

    if word_completed?(@fragment)
      return false
    end
    next_player!

    true
  end

  def next_player!
    temp = @current_player
    @current_player = @previous_player
    @previous_player = temp
  end

  #take_turn(player):
  # gets a string from the player until a valid play is made;
  #  then updates the fragment and checks against the dictionary. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright).
  def take_turn(player)
    valid_input = false
    until valid_input
      player_char = player.guess
      valid_input = valid_play?(player_char)
      unless valid_input
        player.alert_invalid_guess
      end
    end
    # debugger
    @fragment += player_char
  end

  def word_completed?(word)
    # debugger
    @dictionary[word]
  end

  #valid_play?(string): Checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment
  def valid_play?(string)
    unless ("a".."z").to_a.include?(string)
      return false
    end

    wordIncludeFragment = dictionary.keys.any? { |key| key.include?(string) }

    if wordIncludeFragment
      return true
    end

    false
  end
end
