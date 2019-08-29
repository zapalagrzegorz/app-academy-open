class AIplayer

  # testing purposes
  attr_accessor :known_cards, :matching_pair, :picked_card

  attr_reader :score
  # attr_reader :known_cards

  def initialize
    @known_cards = {}
    @matched_cards = {}
    @matching_pair = []
    @picked_card = {}
    @score = 0
    # debugger
  end

  #   hould take in a position and the
  # value of the card revealed at that location. It should then store it in a @known_cards hash.
  # def receive_revealed_card
  def receive_revealed_card(position, value)
    # debugger
    @known_cards[position] = value
  end

  def make_guess(guesses_list)
    # debugger

    update_matching_cards(guesses_list)

    if match?
      return @matching_pair.shift
    end

    picked_card_position = pick_any_unknown_position(guesses_list)
    picked_card_value = guesses_list[picked_card_position]

    receive_revealed_card(picked_card_position, picked_card_value)
    set_matching_cards

    picked_card_position
    # end
  end

  def pick_any_unknown_position(possible_picks)
    unknown_positions = possible_picks.keys - @known_cards.keys

    unknown_positions.sample
  end

  def match?
    true if @matching_pair.length.positive?
  end

  def know_any_cards?
    @known_cards.keys.length.positive?
  end

  # zachowa na liście pasujących te, które są nieodkryte
  def update_matching_cards(possible_cards)
    @matching_pair = @matching_pair.select do |matching_position|
      possible_cards.keys.include?(matching_position)
    end
  end

  def set_matching_cards
    matching_value = @known_cards.values.detect do |card_value|
      # debugger
      @known_cards.values.count(card_value) > 1
    end
    # end

    matching_pair_hash = @known_cards.select { |k| @known_cards[k] == matching_value }
    # hash select return select
    # @known_cards.remove pairs
    # usunięcie z listy (hash) znanych kart, kart sparowanych
    @known_cards = @known_cards.select { |k, v| @known_cards.values.count(v) == 1 }

    @matching_pair = matching_pair_hash.keys
  end

  def record_score
    @score += 1
  end

  def to_s
    "AI Player"
  end
end
