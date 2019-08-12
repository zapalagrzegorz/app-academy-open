class HumanPlayer
  def initialize
    @known_cards
    @matched_cards = {}
    # pos1 => pos2
  end

  def make_guess(_arg1, _arg2)
    puts "Make a pick of a tile: "
    gets.chomp
  end

  def receive_revealed_card
  end

  def receive_match(posCard1, posCard2)
  end

  #   def get_input
  #   end
end
