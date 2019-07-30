# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(numArr)
    peaks = []

    # first
    peaks << numArr[0] if numArr[0] > numArr[1]
    
    # last
    peaks << numArr[-1] if numArr[-1] > numArr[-2]
    
    # between
    (1...numArr.length-1).each do |idx|
        peaks << numArr[idx] if numArr[idx] > numArr[idx-1] && numArr[idx] > numArr[idx + 1]
    end

    peaks
end

p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]
