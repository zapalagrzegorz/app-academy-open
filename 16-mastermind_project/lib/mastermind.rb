require_relative "code"

class Mastermind
  def initialize(length)
    @secret_code = Code.random(length)
  end

  def print_matches(guess)
    p "exect matches: #{@secret_code.num_exact_matches(guess)}"
    p "near matches: #{@secret_code.num_near_matches(guess)}"
  end

  def ask_user_for_guess
    puts "Enter a code"
    guess = Code.from_string(gets.chomp)
    print_matches(guess)
    guess == @secret_code
  end
end
