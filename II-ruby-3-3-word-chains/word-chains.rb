require "set"
require "byebug"

class WordChainer
  # store your dictionary as a Set. The Set#include? method is much faster than Array#include?, since the Array version needs to iterate through all the elements of the array, whereas Set uses a cool trick we'll learn about when we get to the algorithms curriculum.

  def initialize(dictionary_file_name)
    @dictionary = Set.new

    #    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
    File.foreach(dictionary_file_name) do |line|
      @dictionary.add(line.chomp)
    end
  end

  #   This should return all words in the dictionary one letter different than the current word.
  #    By "one letter different" we mean that both words have the same length and only differ at one position, e.g. "mat" and "cat" count as adjacent words, but "cat" and "cats" do not, nor do "cola" and "cool."
  def adjacent_words(word)
    # variable name *masks* (hides) method name; references inside
    # `adjacent_words` to `adjacent_words` will refer to the variable,
    # not the method. This is common, because side-effect free methods
    # are often named after what they return.
    adjacent_words = []
    # word.split("")

    @dictionary.each do |entry|
      # byebug if "abaci" == entry
      if word.length == entry.length && one_letter_different?(word, entry)
        adjacent_words << entry
      end
    end

    adjacent_words
  end

  # tu została obrana naiwna strategia porównywania
  # słowa szukanego z każdym słowem ze słownika

  # dużo szybsze jest zmienianie danego słowa po literze i zaglądanie do słownika
  # bo sprawdzanie ma stałą szybkość O(1)
  def one_letter_different?(word, entry)
    similiarity_flag = 0

    entry.each_char.with_index do |char, index|
      if char == word[index]
        similiarity_flag += 1
      end
    end

    return true if similiarity_flag == word.length - 1

    false
  end

  def run(source, target = "")
    @current_words = [source]
    @all_seen_words = { source => nil }

    #  @current_words, @all_seen_words = [source], { source => nil }

    # zatrzymaj wcześniej jeśli w grafie (zbiorze) słów masz już szukane słowo
    # @current_words.empty? || @all_seen_words.include?(target)
    until @current_words.empty?
      explore_current_words()
      # explore_current_words
    end

    puts build_path(target)
  end

  # buduje ścieżki graf skierowany słów w @all_seen_words
  # graf jest budowany etapami, po jednej odległości węzła, po jednej odmiennej
  # literze
  # po każdej iteracji sprawdza czy są nowe węzły
  def explore_current_words()
    new_current_words = []
    @current_words.each do |current_word|
      adjacent_words = adjacent_words(current_word)

      adjacent_words.each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)

        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
      end
    end

    # After we finish looping through all the @current_words, print out new_current_words, and reset @current_words to new_current_word
    # new_current_words.each { |word| puts " #{word} -> #{@all_seen_words[word]}" }

    @current_words = new_current_words
    # sleep(1)
  end

  # looks up the target in @all_seen_words
  def build_path(target)
    path = [target]

    until @all_seen_words[target].nil?
      word_letter_away = @all_seen_words[target]
      path << word_letter_away
      target = word_letter_away
    end

    path
    # @all_seen_words[target]

    # szukamy gallon
    # @all_seen_words["gallon"] => gallop
    # @all_seen_words["gallop"] => wallop
    # ...["wallop"] => wallow
    # ...["wallow"] => fallow
    # ...["fallow"] => fellow
    # ...["fellow"] => yellow
    # ..."yellow" => nil
  end
end

word_chainer = WordChainer.new("dictionary.txt")

word_chainer.run("yellow", "gallop")

# solution
# def adjacent_words2(word)
# adjacent_words = []

# NB: I gained a big speedup by checking to see if small
# modifications to the word were in the dictionary, vs checking
# every word in the dictionary to see if it was "one away" from
# the word. Can you think about why?
#   word.each_char.with_index do |old_letter, i|
#     ("a".."z").each do |new_letter|
#       # Otherwise we'll include the original word in the adjacent
#       # word array
#       next if old_letter == new_letter

#       new_word = word.dup
#       new_word[i] = new_letter

#       adjacent_words << new_word if dictionary.include?(new_word)
#     end
#     end
#   end

#   adjacent_words
# end

# word_chainer
