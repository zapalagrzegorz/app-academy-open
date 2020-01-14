# frozen_string_literal: true

require 'byebug'

# naive approach
def windowed_max_range(array, window_size)
  current_max_range = 0

  i = 0
  until window_size > array.length
    #  slicing an array is rather costly (again, O(n))
    sub_arr = array[i...window_size]
    difference = sub_arr.max - sub_arr.min
    current_max_range = difference if difference > current_max_range
    i += 1
    window_size += 1
  end

  current_max_range
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
# How many iterations are required at each step?
# What is its overall time complexity in Big-O notation?

# iterate over array - O(n)
# min and max 2* O(n) -> O(n^2)
