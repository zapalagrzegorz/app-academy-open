class HumanPlayer
  attr_reader :score

  def initialize
    @known_cards
    @matched_cards = {}
    @score = 0
    # pos1 => pos2
  end

  def make_guess(_arg1)
    puts "Make a pick of a tile: "
    gets.chomp
  end

  def receive_revealed_card
  end

  def receive_match(posCard1, posCard2)
  end

  def record_score
    @score += 1
  end

  #   def get_input
  #   end
end
