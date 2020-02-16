# frozen_string_literal: true

require 'byebug'
# Largest Contiguous Sub - sum
# You have an array of integers and you want to find
# the largest contiguous (together in sequence) sub-sum.
# Find the sums of all contiguous sub-arrays and return the max.

list2 = [2, 3, -6, 7, -6, 7]
#   largest_contiguous_subsum(list) # => 8

#   # possible sub-sums
#   [5]           # => 5
#   [5, 3]        # => 8 --> we want this one
#   [5, 3, -7]    # => 1
#   [3]           # => 3
#   [3, -7]       # => -4
#   [-7]          # => -7
# Write a function that iterates through the array and finds all sub-arrays using nested loops. First make an array to hold all sub-arrays. Then find the sums of each sub-array and return the max.

# Discuss the time complexity of this solution.

# n^2
# O(n^3) cubic space
def sub_sum(arr)
  sub_arrs = []
  arr.each_with_index do |element, element_idx|
    sub_arrs << [element]
    sub_arr = [element]

    # można by range' rozważyć
    arr.each_with_index do |next_element, next_idx|
      next if next_idx <= element_idx

      sub_arr << next_element
      sub_arrs << sub_arr.dup
    end
  end

  sub_arrs_count = sub_arrs.map(&:sum)

  sub_arrs_count.max
end

# Phase II

# Let's make a better version. Write a new function using O(n) time with O(1) memory. Keep a running tally of the largest sum. To accomplish this efficient space complexity, consider using two variables. One variable should track the largest sum so far and another to track the current sum. We'll leave the rest to you.

list = [5, 3, -9, 9]

def sub_sum_2(arr)
  largest = arr.first

  # 0..3
  (0...arr.length).each do |begin_idx|
    current = arr[begin_idx]
    # tablica jest zwiększana o jeden element i sprawdzana
    # next_idx = element_idx + 1
    # 3 + 1
    # debugger
    (begin_idx + 1..arr.length).each do |end_idx|
      # debugger
      current = ([current] + arr[begin_idx + 1..end_idx]).sum
      largest = current if current > largest
    end
  end

  # array.each_index do |idx1|
  #   (idx1..array.length - 1).each do |idx2|
  #     subs << array[idx1..idx2]
  #   end
  # end

  largest
end

# O(n) linear time
# O(1) constant space

list = [5, 3, -9, 9]
def largest_contiguous_subsum2(arr)
  largest = arr.first
  current = arr.first

  (1...arr.length).each do |i|
    # zeruje licznik "streak" jeśli suma kolejnych była ujemna
    current = 0 if current < 0
    # 1. 5 + 3
    # 2. 5 + 3 + -7
    # 3.
    current += arr[i]
    largest = current if current > largest
  end

  largest
end

# [5, 3, -7]

p 'sub_sum_2 -'
p sub_sum_2(list)
# p largest_contiguous_subsum2(list)
p largest_contiguous_subsum2(list)
