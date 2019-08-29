require "colorize"

class Tile
  def initialize(value, given = false)
    @value = value
    @given = given
  end

  def to_s
    if @given
      print "#{@value}".colorize(:blue)
    else
      print "#{@value}"
    end
  end
end
