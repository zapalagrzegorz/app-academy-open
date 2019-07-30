class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample()
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    secret_word_arr = @secret_word.split("")
    secret_word_arr.each_index.select { |i| @secret_word[i] == char }
  end

  def fill_indices(char, arr_indices)
    arr_indices.each { |idx| @guess_word[idx] = char }
  end

  def try_guess(char)
    if already_attempted?(char)
      p "that has already been attempted"
      return false
    end

    @attempted_chars << char
    matching_indices = get_matching_indices(char)

    if matching_indices.empty?
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(char, matching_indices)
    end

    true
  end

  def ask_user_for_guess
    p "Enter a char:"
    try_guess(gets.chomp)
  end

  def win?
    if guess_word.join("") == @secret_word
      p "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose?
      p @secret_word
      return true
    else
      return false
    end
  end
end
