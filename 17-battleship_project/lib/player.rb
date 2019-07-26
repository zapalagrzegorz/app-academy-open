class Player
  def get_move
    puts "enter a position with coordinates separated with a space like `4 7`"
    userNumbers = gets.chomp.split(" ").map(&:to_i)
    [userNumbers[0], userNumbers[1]]
  end
end
