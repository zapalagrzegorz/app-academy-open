
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "Player #{name}, give a char"
    gets.chomp
  end

  def alert_invalid_guess
    puts "#{name}, please, give only one char, like 'a' or 'b'"
  end
end
