# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
require "byebug"

def least_common_multiple(num_1, num_2)
  multiple = [num_1, num_2].max

  until multiple % num_1 == 0 && multiple % num_2 == 0
    multiple += 1
  end
  multiple

  # (multiple.. num1 * num2) do
end

#

# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
  bigrams = Hash.new(0)
  (0...str.size - 1).each do |index|
    # bigram = str[index] + str[index + 1]
    bigram = str[index..index + 1]
    bigrams[bigram] += 1
    # .each do |first|
    # (first)
  end
  sorted = bigrams.sort_by { |_bigram, count| count }
  sorted[-1][0]
  # sorted.last[0]
end

# bigrams
#   select based on count
#

class Hash
  # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
  def inverse
    new_hash = {}
    keys = self.keys
    values = self.values
    # self.each |k, v|
    (0...self.length).each do |idx|
      new_key = values[idx]
      new_value = keys[idx]
      new_hash[new_key] = new_value
    end
    new_hash
  end

  # self.each |k, v|
  # new_hash[v] = k
  # end
end

class Array
  # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
  def pair_sum_count(num)
    pairs = 0
    (0...self.size - 1).each do |idx|
      (idx + 1...self.size).each do |next_idx|
        pairs += 1 if self[idx] + self[next_idx] == num
      end
    end
    pairs
  end

  # Write a method, Array#bubble_sort, that takes in an optional proc argument.
  # When given a proc, the method should sort the array according to the proc.
  # When no proc is given, the method should sort the array in increasing order.
  def bubble_sort(&prc)
    prc ||= Proc.new { |value1, value2| value1 <=> value2 }
    sorted = false

    while !sorted
      sorted = true
      (0...self.length - 1).each do |index|
        if prc.call(self[index], self[index + 1]) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          sorted = false
        end
      end
    end
    self
  end
end

# [5, 4, 7].bubble_sort()

if __FILE__ == $PROGRAM_NAME
  least_common_multiple(4, 10)
end
