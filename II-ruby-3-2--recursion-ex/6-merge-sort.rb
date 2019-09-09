require "byebug"

# Merge Sort

# Implement a method merge_sort that sorts an Array:

#     The base cases are for arrays of length zero or one. Do not use a length-two array as a base case. This is unnecessary.
#     You'll want to write a merge helper method to merge the sorted halves.
#     To get a visual idea of how merge sort works, watch this gif and check out this diagram.

def merge_sort(arr)
  return arr if arr.length <= 1

  leftArr = arr[0...arr.length / 2]
  rightArr = arr[(arr.length / 2)...arr.length]

  left = merge_sort(leftArr)
  right = merge_sort(rightArr)

  merge(left, right)
end

def merge(leftArr, rightArr)
  sortedArr = []
  leftIndex = 0
  rightIndex = 0

  while (leftIndex < leftArr.length && rightIndex < rightArr.length)
    if (leftArr[leftIndex] < rightArr[rightIndex])
      sortedArr << leftArr[leftIndex]
      leftIndex += 1
    else
      sortedArr << rightArr[rightIndex]
      rightIndex += 1
    end
  end

  while leftIndex < leftArr.length
    sortedArr << leftArr[leftIndex]
    leftIndex += 1
  end

  while rightIndex < rightArr.length
    sortedArr << rightArr[rightIndex]
    rightIndex += 1
  end

  sortedArr
end

p merge_sort([2, 6, 10, 12, 23, 0, 8, 5, 9, 3, 4])
