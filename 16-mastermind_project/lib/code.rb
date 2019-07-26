require "byebug"

class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow,
  }

  attr_reader :pegs

  def self.valid_pegs?(chars)
    # debugger
    # chars.each { |char| p char }
    # chars.all? { |char| POSSIBLE_PEGS.haskeys.include?(char.upcase) }
    chars.all? { |char| POSSIBLE_PEGS.key?(char.upcase) }
    # chars.all? { |char| p char.upcase }
  end

  def self.random(length)
    secret = []
    length.times { secret << POSSIBLE_PEGS.keys.sample }
    self.new(secret)
  end

  def self.from_string(string)
    self.new(string.split(""))
  end

  def initialize(chars)
    raise "Invalid pegs" unless Code.valid_pegs?(chars)

    @pegs = chars.map(&:upcase)
  end

  def [](idx)
    pegs[idx]
  end

  def length
    pegs.length
  end

  def num_exact_matches(guess)
    exact_matches = 0
    (0...length).each do |idx|
      exact_matches += 1 if guess[idx] == pegs[idx]
    end
    exact_matches
  end

  def num_near_matches(guess)
    near_matches = 0
    (0...length).each do |idx|
      if pegs.include?(guess[idx]) && guess[idx] != pegs[idx]
        near_matches += 1
      end
    end
    near_matches
  end

  def ==(guess)
    pegs == guess.pegs
  end
end

# Code.random(5)
