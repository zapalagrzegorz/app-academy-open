require_relative "player"
require "set"
require "byebug"

class Game
  # attr_reader

  # debug purposes
  attr_accessor :current_player, :previous_player, :fragment, :losses

  @players = []

  # ale inaczej accessor nie działał :/
  def players
    @players
  end

  def self.testable
    players = []
    players << Player.new("Gelo")
    players << Player.new("Kylo")

    self.new(players)
  end

  def initialize(players = [])
    @fragment = ""
    @dictionary = Set.new
    if players.empty?
      @players = set_players
    else
      @players = players
    end

    # czy klucz będzie referencją do atrybutu current/prev player?
    # @current_player => 0,
    # @previous_player => 0,
    # }
    # debugger

    # While this creates a new default object each time
    # h = Hash.new { |hash, key| hash[key] = "Go Fish: #{key}" }
    # h["c"]           #=> "Go Fish: c"

    @losses = Hash.new { |hash, key| hash[key] = 0 }
    @players.each do |player|
      @losses[player]
    end
    # nadmierna komplikacja dla ustawienia inicjalizacji domyślnej
    # wartości klucza Hasha
    # przecie można by było zrobić tak:
    # @losses[player] = 0
    @current_player = @players[0]
    @previous_player = @players[-1]
  end

  def run
    until game_over?
      play_round
    end
  end

  # http://ruby-for-beginners.rubymonstas.org/advanced/private_methods.html
  # debug purposes
  # private

  def play_round
    display_standings

    until word_completed?
      take_turn
      next_player!
    end

    check_and_eleminate_loser

    puts "__________________________"
    puts
  end

  def game_over?
    return true if @players.length == 1
  end

  # HELPERS

  def set_players
    puts "Give number of players 2-4"
    players_num = gets.chomp.to_i
    players = []
    players_num.times do |player_num|
      puts "Please, give player #{player_num + 1} name"
      name = gets.chomp
      players << Player.new(name)
    end

    players
  end

  def next_player!
    current_player_index = @players.find_index(@current_player)
    next_player_index = (current_player_index + 1) % @players.length

    @previous_player = @current_player
    @current_player = @players[next_player_index]
  end

  #take_turn(player):
  # gets a string from the player until a valid play is made;
  #  then updates the fragment and checks against the dictionary. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright).
  def take_turn
    valid_input = false
    puts ""
    puts "Current text is: #{@fragment}"

    until valid_input
      player_char = @current_player.guess
      valid_input = valid_play?(player_char)
      unless valid_input
        @current_player.alert_invalid_guess
      end
    end

    @fragment += player_char
  end

  def word_completed?
    @dictionary.include?(@fragment)
  end

  #valid_play?(string): Checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment
  def valid_play?(string)
    unless ("a".."z").to_a.include?(string)
      return false
    end

    newFragment = @fragment + string

    # if @dictionary.empty?
    #   dictionary
    # end

    wordIncludeFragment = dictionary.any? do |word|
      # debugger
      # puts '#{word}'
      word.start_with?(newFragment)
    end

    if wordIncludeFragment
      return true
    end

    false
  end

  def record(player)
    # debugger
    "GHOST"[0...@losses[player]]
  end

  def check_and_eleminate_loser
    @losses[@previous_player] += 1
    puts "!!!"
    puts "#{@previous_player.name} has lost round."
    puts

    if @losses[@previous_player] == 2
      eleminate_loser!(@previous_player)
    end

    @fragment = ""
  end

  def eleminate_loser!(loser)
    # debugger
    remaining_players = @players.select { |player| player != loser }
    @players = remaining_players
  end

  def players_records
    @players.each do |player|
      player_record = record(player)
      # empty
      puts "#{player.name} : #{player_record.empty? ? "0" : player_record}"
    end
  end

  def dictionary
    if @dictionary.empty?
      set_dictionary
    else
      @dictionary
    end
    # debug-purposes
    @dictionary
  end

  def set_dictionary
    # if File.exist?("dictionary.txt")
    File.foreach("dictionary.txt") do |line|
      # debugger
      @dictionary.add(line.chomp)
    end
    # end
  end

  # UI methods
  def display_standings
    puts "Current fragment: #{@fragment}" unless @fragment.empty?

    if @fragment.empty?
      players_records
    end
    puts
  end
end
