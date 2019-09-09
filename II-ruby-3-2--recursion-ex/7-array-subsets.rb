require "byebug"
# Array Subsets

# Write a method subsets that will return all subsets of an array.

# subsets([]) # => [[]]
# subsets([1]) # => [[], [1]]
# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# subsets([1, 2, 3])
# # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# You can implement this as an Array method if you prefer.

# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:

#     Those that do not contain 3 (all of these are subsets of [1, 2]).
#     For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.

# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# subsetArr = []

def subsets(arr)
  return [[]] if arr.empty?
  # debugger
  # take - return first n elements

  subArr = arr.take(arr.count - 1)

  subs = subsets(subArr)

  # concat Appends the elements of other_ary to self.
  # tyle co +
  subs.concat(subs.map { |sub| sub + [arr.last] })
end

# [].concat

p subsets([1])
# num
# subsets(1, [2])
# subsets(0, [2, 1])
# [2]
# subsetArr == [[2,1]]

# subset <<
# [2]
# push(arr[0])
# foreach, pusharr[0]

#
# [2]
# [2]
#
# def mergeSubsets(left, right)
#   [[left], [right], [left, right]]
# end
