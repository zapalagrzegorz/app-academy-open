
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
    puts "#{name}, invalid input data: one char, like 'a' or 'b' oraz your fragment doesn't make sense"
  end
end
