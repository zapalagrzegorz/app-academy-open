# frozen_string_literal: true

require 'byebug'
require_relative './permutations'

# Anagrams

# Our goal today is to write a method that determines if two given words are anagrams. This means that the letters in one word can be rearranged to form the other word. For example:

# anagram?("gizmo", "sally")    #=> false
# anagram?("elvis", "lives")    #=> true

# Assume that there is no whitespace or punctuation in the given strings.

# Phase I:

# Write a method #first_anagram? that will generate
# and store all the possible anagrams of the first string.
# Check if the second string is one of these.

# Hints:

#     For testing your method, start with small input strings, otherwise you might wait a while
#     If you're having trouble generating the possible anagrams, look into this method.

# What is the time complexity of this solution? What happens if you increase the size of the strings?

# n! * n^2
def first_anagram?(str, comparable)
  all_anagrams = permutations(str.split(''))
  # all possible anagrams of string
  all_anagrams.map { |word| word.join('') }.flatten.include?(comparable)
end

# Write a method #second_anagram? that iterates over the first string. For each letter in the first string, find the index of that letter in the second string (hint: use Array#find_index) and delete at that index. The two strings are anagrams if an index is found for every letter and the second string is empty at the end of the iteration.

# Try varying the length of the input strings. What are the differences between #first_anagram? and #second_anagram?

# O(n^2)?
def second_anagram?(first, second)
  second_arr = second.split('')

  first.split('').each do |char|
    index = second_arr.find_index(char)

    return false unless index

    second_arr.delete_at(index)
  end

  second_arr.empty?
end

# anagram?("elvis", "lives")    #=> true

# Write a method #third_anagram? that solves the problem by sorting both strings alphabetically. The strings are then anagrams if and only if the sorted versions are the identical.

# What is the time complexity of this solution? Is it better or worse than #second_anagram??

# depends on sorting algorithm (from n*log(n) to n^2 when already sorted)
def third_anagram?(first, second)
  first.split('').sort.join('') == second.split('').sort.join('')
end

# Write one more method #fourth_anagram?. This time, use two Hashes to
# store the number of times each letter appears in both words. Compare the resulting hashes.

# What is the time complexity?
# O(n) / 3n - time
# O(n) constant space
# Here, the intuitive answer to the space complexity is
# O(n) because we're adding a separate key in the hash
# for each character. But if the keys in the hash are single
# characters, then how many different keys can we have?
# How many different chars in the alphabet? A constant number
# (26 + numbers and symbols for English alphabet).
def fourth_anagram?(first, second)
  first_counter = first.split('').each_with_object(Hash.new(0)) { |char, hsh| hsh[char] += 1 }
  second_counter = second.split('').each_with_object(Hash.new(0)) { |char, hsh| hsh[char] += 1 }

  # first_counter.each { |key, value| return false if second_counter[key] != value }
  first_counter == second_counter
  # counter = {}
end
puts 'second_anagram?'

puts second_anagram?('gizmo', 'sally') ? 'false' : 'correct'

puts second_anagram?('elvis', 'lives') ? 'correct' : 'false'

puts 'third_anagram?'

puts third_anagram?('gizmo', 'sally') ? 'false' : 'correct'

puts third_anagram?('elvis', 'lives') ? 'correct' : 'false'

puts 'fourth_anagram?'

puts fourth_anagram?('gizmo', 'sally') ? 'false' : 'correct'

puts fourth_anagram?('elvis', 'lives') ? 'correct' : 'false'
