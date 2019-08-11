require "byebug"

class Card
  # testing purposes
  attr_reader :value

  attr :is_face_up

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
