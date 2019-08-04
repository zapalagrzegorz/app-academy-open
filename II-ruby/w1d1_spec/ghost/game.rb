require_relative "player"
require "byebug"

class Game
  # attr_reader :losses

  # debug
  attr_accessor :current_player, :previous_player, :fragment

  @@players = []

  # ale inaczej accessor nie działał
  def players
    @@players
  end

  def losses
    @losses
  end

  def self.add_player(player)
    @@players << player
  end

  def self.set_players
    puts "Give number of players 2-4"
    players_num = gets.chomp.to_i
    players_num.times do |player_num|
      puts "Please, give player #{player_num} name"
      name = gets.chomp
      new_player = Player.new(name)
      Game.add_player(new_player)
    end
  end

  def initialize
    @fragment = ""
    @current_player = @@players[0]
    @previous_player = @@players[-1]
    @dictionary = Hash.new()

    # counter // ew inicjalizować zerem zamiast przypisania w 40
    @losses = {}
    # czy klucz będzie referencją do atrybutu current/prev player?
    # @current_player => 0,
    # @previous_player => 0,
    # }
    @@players.each do |player|
      @losses[player] = 0
    end
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
    puts "Current fragment: #{@fragment}" unless @fragment.empty?
    take_turn(@current_player)

    next_player!
  end

  def next_player!
    current_player_index = @@players.find_index(@current_player)
    next_player_index = (current_player_index + 1) % @@players.length

    @previous_player = @current_player
    @current_player = @@players[next_player_index]
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

    newFragment = @fragment + string
    wordIncludeFragment = dictionary.keys.any? { |key| key.include?(newFragment) }

    if wordIncludeFragment
      return true
    end

    false
  end

  def record(player)
    # debugger
    "GHOST"[0...losses[player]]
  end

  def run
    # debugger
    display_standings if @fragment == ""

    play_round

    if word_completed?(@fragment)
      losses[@previous_player] += 1
      puts "#{@previous_player.name} has lost round."
      puts
      @fragment = ""
      # test
      # usun gracza
      check_and_eleminate_loser

      # false gdy tylko jeden
      return false if @@players.length == 1
    end

    true
  end

  def check_and_eleminate_loser
    if losses[@previous_player] == 2
      eleminate_loser!(@previous_player)
    end
  end

  def eleminate_loser!(loser)
    debugger
    remaining_players = @@players.select { |player| player != loser }
    @@players = remaining_players
  end

  def display_standings
    @@players.each do |player|
      player_record = record(player)
      puts "#{player.name} : #{player.empty? ? "0" : player_record}"
    end
    puts
    # current_player_record = record(@current_player)
    # previous_player_record = record(@previous_player)

    # puts "#{@previous_player.name} : #{previous_player_record.empty? ? "0" : previous_player_record}"
  end
end
