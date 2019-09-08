require "byebug"
# Binary Search

# The binary search algorithm begins by comparing the target value to the value of the middle element of the sorted array. If the target value is equal to the middle element's value, then the position is returned and the search is finished. If the target value is less than the middle element's value, then the search continues on the lower half of the array; or if the target value is greater than the middle element's value, then the search continues on the upper half of the array. This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element of the remaining elements - until the target value is either found (and its associated element position is returned), or until the entire array has been searched (and "not found" is returned).

# Write a recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays. Make sure to return the location of the found object (or nil if not found!). Hint: you will probably want to use subarrays.

# Make sure that these test cases are working:

# bsearch([1, 2, 3], 1) # => 0
# bsearch([2, 3, 4, 5], 3) # => 1
# bsearch([2, 4, 6, 8, 10], 6) # => 2
# bsearch([1, 3, 4, 5, 9], 5) # => 3
# bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def bsearch(arr, target)
  return nil if arr.empty?
  middlePosition = arr.length / 2
  return middlePosition if target == arr[middlePosition]

  if target < arr[middlePosition]
    half_array = arr.take(middlePosition)
    bsearch(half_array, target)
  else
    half_array = arr.drop(middlePosition + 1)
    sub_answer = bsearch(half_array, target)
    sub_answer.nil? ? nil : (middlePosition + 1) + sub_answer
  end
end

#   middle = 3
# half_arr = [5,6]
# sub_answer = bsearch([5,6], 5) => 0

# sub_answer.nil? ? nil : (middlePosition + 1) + sub_answer
# (middlePosition = 3)
# 3+ 1 + 0

# #
# half_array = [5]
#   bsearch(half_array, target) => return 0

# return 0

# SOLUTION
def bsearchSolution(nums, target)
  # nil if not found; can't find anything in an empty array
  return nil if nums.empty?

  probe_index = nums.length / 2
  case target <=> nums[probe_index]
  when -1
    # search in left
    bsearchSolution(nums.take(probe_index), target)
  when 0
    probe_index # found it!
  when 1
    # search in the right; don't forget that the right subarray starts
    # at `probe_index + 1`, so we need to offset by that amount.
    sub_answer = bsearchSolution(nums.drop(probe_index + 1), target)
    sub_answer.nil? ? nil : (probe_index + 1) + sub_answer
  end

  # Note that the array size is always decreasing through each
  # recursive call, so we'll either find the item, or eventually end
  # up with an empty array.
end
