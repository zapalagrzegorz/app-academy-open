require "colorize"

class Tile
  attr_accessor :value
  attr_reader :given

  def initialize(value)
    @value = value
    @given = value == 0 ? false : true
  end

  def to_s
    if @given
      return "#{@value}".colorize(:blue)
    else
      return "#{@value}"
    end
  end
end
