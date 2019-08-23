require "byebug"

class Card
  # testing purposes
  attr_reader :value

  attr :is_face_up

  def self.generate_random_cards(board_size, alphabet)
    unique_card_number = (board_size ** 2) / 2
    random_card_values = alphabet.sample(unique_card_number)
    random_card_values += random_card_values
    random_card_values.shuffle!
    random_card_values.map { |rand_value| Card.new(rand_value) }
  end

  def initialize(value)
    @value = value
    @is_face_up = false
  end

  def hide
    @is_face_up = false
  end

  def reveal
    @is_face_up = true
    self
  end

  def to_s
    if @is_face_up == true
      return @value
    else
      return " "
    end
  end

  def ==(other)
    # debugger
    other_value = other.reveal.to_s
    other.hide
    @value == other_value
  end

  # face value
  # up / down
end
