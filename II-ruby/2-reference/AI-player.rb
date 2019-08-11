class AIplayer
  attr_reader :known_cards

  def initialize
    @known_cards = {}
    @matched_cards = {}

    # pos1, pos2
    # card1 = value X
    # card2 = value X
  end

  #   hould take in a position and the
  # value of the card revealed at that location. It should then store it in a @known_cards hash.  def receive_revealed_card
  def receive_revealed_card(card)
    @known_cards[card] = card.to_s
  end

  def make_guess(guesses_list)
    # debugger
    position, value = guesses_list.first
    @known_cards[position] = value
    return position
  end
end
