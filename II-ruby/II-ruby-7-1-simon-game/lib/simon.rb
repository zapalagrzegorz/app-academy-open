require "byebug"
require "colorize"

class Simon
  COLORS = %w(red blue green yellow).freeze

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @game_over = false
    @seq = []
    @sequence_length = 1
  end

  def play
    until @game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    system("clear")
    add_random_color

    @seq.each do |color|
      puts "#{color}".colorize(color.to_sym)
      sleep(2)
      system("clear")
    end
  end

  def require_sequence
    round = 0
    # debugger
    until round == @sequence_length
      player_sequence = gets.chomp
      if player_sequence == @seq[round]
        round += 1
      else
        # debugger

        @game_over = true
        break
      end
    end
  end

  def add_random_color
    seq << COLORS[rand(COLORS.length)]
    # @sequence_length = sequence_length + 1
  end

  def round_success_message
    puts "Good round!"
    sleep(2)
  end

  def game_over_message
    puts "Sorry, you've lost"
  end

  def reset_game
    @seq = []
    @sequence_length = 1
    @game_over = false
  end
end
