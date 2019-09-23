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
    @all_seen_words = [source]

    until @current_words.empty?
      new_current_words = []

      @current_words.each do |current_word|
        adjacent_words = adjacent_words(current_word)

        adjacent_words.each do |adjacent_word|
          next if @all_seen_words.include?(adjacent_word)

          new_current_words << adjacent_word

          @all_seen_words << adjacent_word
        end
      end

      puts new_current_words
      @current_words = new_current_words
      sleep(1)
    end

    # After we finish looping through all the @current_words, print out new_current_words, and reset @current_words to new_current_word
  end
end

word_chainer = WordChainer.new("dictionary.txt")

word_chainer.run("abaci")

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

# Next, let's begin writing a method #run(source, target). Our strategy is:

# Keep a list of @current_words. Start this with just [source].

# Also keep a list of @all_seen_words. Start this with just [source].

# Begin an outer loop which will run as long as @current_words is not empty. This will halt our exploration when all words adjacent to @current_word have been discovered.

# Inside this loop, create a new, empty list of new_current_words. We're going to fill this up with new words (that aren't in @all_seen_words) that are adjacent (one step away) from a word in @current_words.

# To fill up new_current_words, begin a second, inner loop through @current_words.

# For each current_word, begin a third loop, iterating through all adjacent_words(current_word). This is a triply nested loop.

# For each adjacent_word, skip it if it's already in @all_seen_words; we don't need to reconsider a word we've seen before.

# Otherwise, if it's a new word, add it to both new_current_words, and @all_seen_words so we don't repeat it.

# After we finish looping through all the @current_words, print out new_current_words, and reset @current_words to new_current_words.

# Make sure your run method eventually terminates: it should eventually enumerate all the words that are reachable from source, at which point new_current_words will come out empty. After setting @current_words = new_current_words the outermost loop should terminate.

# After executing #run, @all_seen_words will contain a list of all the words encountered in our 'exploration.'

# Test your word chainer to make sure it outputs (1) first the words that are one letter away from source, (2) next words that are one letter away from words one letter away from source (i.e., two letters away from source), etc. This is a breadth first enumeration of words that you can reach from the source.

# Call your TA over to check your work.
