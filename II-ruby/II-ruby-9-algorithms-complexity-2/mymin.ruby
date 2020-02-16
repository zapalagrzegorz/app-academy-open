# frozen_string_literal: true

list = [0, 3, 5, 4, -5, 10, 1, 90]
# my_min(list) # =>  -5

# Phase I

# First, write a function that compares each element to every other element of the list. Return the element if all other elements in the array are larger.
# What is the time complexity for this function?
# def quadratic_biggest_fish(fishes)
#   fishes.each_with_index do |fish1, i1|
#     max_length = true

#     fishes.each_with_index do |fish2, i2|
#       next if i1 == i2
#       max_length = false if fish2.length > fish1.length
#     end

#     return fish1 if max_length
#   end

# end
# complexity n^2
def my_min_1(arr)
  arr.each do |element|
    min = true
    arr.each do |compare_element|
      min = false if compare_element < element
    end

    return element if min
  end
end

p my_min_1(list)

def my_min_2(arr)
  arr.inject do |memo, element|
    element < memo ? element : memo
  end
end

p my_min_2(list)
