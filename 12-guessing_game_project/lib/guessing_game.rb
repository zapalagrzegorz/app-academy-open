class GuessingGame
  def initialize(min, max)
    @secret = rand(min..max)
    @num_attempts = 0
    @game_over = false
  end

  def num_attempts
    @num_attempts
  end

  def game_over?
    @game_over
  end

  def check_num(num)
    @num_attempts += 1
    if @secret == num
      @game_over = true
      p "you win!"
    elsif @secret < num
      p "number is too big"
    else
      p "number is too small"
    end
  end

  def ask_user
    p "Enter a number?"
    check_num(gets.chomp.to_i)
  end
end
