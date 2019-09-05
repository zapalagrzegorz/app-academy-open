require "byebug"
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.

def range(startNum, endNum)
  return [] if endNum < startNum

  return [startNum] if startNum + 1 == endNum

  [startNum] + range(startNum + 1, endNum)
end

# Write both a recursive and iterative version of sum of an array.
def sumIterative
end

def sumRecursive
end
