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
  #   end

  #   adjacent_words
  # end
end

WordChainer.new("dictionary.txt").adjacent_words("aback")
# word_chainer
