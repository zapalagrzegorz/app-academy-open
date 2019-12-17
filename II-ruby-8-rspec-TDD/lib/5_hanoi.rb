# frozen_string_literal: true

# require 'byebug'
class Hanoi
  attr_reader :towers

  def initialize(size = 3)
    @size = size
    @target_tower = (1..size).to_a
    @towers = [(1..size).to_a, [], []]
  end

  def play
    until won?
      prompt

      begin
        input
      rescue InvalidMove => e
        puts e.message
        retry
      end
    end

    show_towers
  end

  def move(moves)
    src, target = moves
    validate_moves(src, target)

    self[target].unshift(self[src].shift)
  end

  def won?
    self[1] == @target_tower || self[2] == @target_tower
  end

  private

  def validate_moves(src, target)
    raise InvalidMove unless src.between?(0, @size - 1)
    raise InvalidMove unless target.between?(0, @size - 1)

    if !self[target].empty? && self[src].last > self[target].first
      raise InvalidMove
    end
  end

  def [](arg)
    @towers[arg]
  end

  def input
    prompt
    move(parse(STDIN.gets.chomp))
  end

  def prompt
    show_towers

    puts "Please enter the source and target tower (e.g., '1,3')"
    print '> '
  end

  def show_towers
    puts "tower #1: #{@towers[0].reverse}"
    puts "tower #2: #{@towers[1].reverse}"
    puts "tower #3: #{@towers[2].reverse}"
  end

  def parse(string)
    move = string.split(',').map { |x| Integer(x) - 1 }
    raise InvalidMove unless move.length == 2 && move.all?(Integer)

    move
  end
end

# Custom move error
class InvalidMove < ArgumentError
  def message
    puts 'Invalid move'
  end
end

Hanoi.new.play if $PROGRAM_NAME == __FILE__
