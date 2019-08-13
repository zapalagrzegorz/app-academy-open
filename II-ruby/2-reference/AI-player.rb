class AIplayer

  # testing purposes
  attr_accessor :known_cards, :matching_pair, :picked_card

  # attr_reader :known_cards

  def initialize
    @known_cards = {}
    @matched_cards = {}
    @matching_pair = []
    @picked_card = {}
    # debugger
  end

  #   hould take in a position and the
  # value of the card revealed at that location. It should then store it in a @known_cards hash.
  # def receive_revealed_card
  def receive_revealed_card(position, value)
    # debugger
    @known_cards[position] = value
  end

  def make_guess(guesses_list, previous_guess = nil)
    # debugger
    if know_any_cards?
      unknown_keys = guesses_list.keys - @known_cards.keys
      unknown_tile_position = unknown_keys[0]
    else
      unknown_tile_position = guesses_list.keys[0]
    end

    value = guesses_list[unknown_tile_position]

    # jeśli właśnie wziął kartę, którą już wcześniej wziął
    # to wówczas weź nowszą pozycję - to chyba błąd
    #
    if match?
      if @matching_pair[0] != guesses_list[previous_guess]
        return @matching_pair.shift
      else
        return @matching_pair.pop
      end
    else
      # debugger
      receive_revealed_card(unknown_tile_position, value)

      return unknown_tile_position
    end
  end

  def match?
    return true if @matching_pair.length.positive?

    matching_value = @known_cards.values.detect do |card_value|
      # debugger
      @known_cards.values.count(card_value) > 1
    end
    # end

    matching_pair_hash = @known_cards.select { |k| @known_cards[k] == matching_value }
    # hash select return select
    # @known_cards.remove pairs
    @known_cards = @known_cards.select { |k, v| @known_cards.values.count(v) == 1 }

    @matching_pair = matching_pair_hash.keys

    @matching_pair.length.positive? ? true : false
  end

  def know_any_cards?
    @known_cards.keys.length.positive?
  end
end
