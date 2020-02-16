# frozen_string_literal: true

# Two sum

# Write a new Array#two_sum method that finds all pairs of positions where the elements at those positions sum to zero.

# NB: ordering matters. We want each of the pairs to be sorted smaller index before bigger index. We want the array of pairs to be sorted "dictionary-wise":

# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]

#     [0, 2] before [2, 1] (smaller first elements come first)
#     [0, 1] before [0, 2] (then smaller second elements come first)
# require 'byebug'

class Array
  def two_sum
    arr = []

    # debugger
    each_with_index do |first, first_idx|
      each_with_index do |second, second_idx|
        if (first + second).zero? && second_idx > first_idx
          arr << [first_idx, second_idx]
        end
      end
    end

    arr
  end
end
