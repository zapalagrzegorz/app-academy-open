# frozen_string_literal: true

# require 'byebug'
class Hanoi
  attr_reader :towers

  def initialize(size = 3)
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
  end

  def move(moves)
    src, target = moves
    # debugger

    if !self[target].empty? && self[src].last > self[target].first
      raise InvalidMove
    end

    # raise InvalidMove if

    self[target].unshift(self[src].shift)
  end

  def won?
    self[1] == @target_tower || self[2] == @target_tower
  end

  private

  def [](arg)
    @towers[arg]
  end

  def input
    prompt
    move(parse(STDIN.gets.chomp))
  end

  def prompt
    puts "Please enter the source and target tower (e.g., '1,3')"
    print '> '
  end

  def parse(string)
    move = string.split(',').map { |x| Integer(x) }
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
