# returns factors of 10 in order

require "byebug"

require "byebug"

class Array
  def my_each(&prc)
    self.size.times do |index|
      prc.call(self[index])
    end

    return self
  end

  def my_select(&prc)
    # debugger
    selected = []
    self.my_each do |item|
      selected << item if prc.call(item) == true
    end

    selected
  end

  def my_reject(&prc)
    saved_elements = []
    self.my_each do |element|
      saved_elements << element if prc.call(element) == false
    end

    saved_elements
  end

  def my_any?(&prc)
    self.my_each do |element|
      return true if prc.call(element) == true
    end

    false
  end

  def my_all?(&prc)
    self.my_each do |element|
      if prc.call(element) == false
        return false
      end
    end

    true
  end

  def my_flatten
    # ostatecznie zwykły element opakuj w tablicę
    # jeśli jest wywołana rekurencyjnie - zostanie połączona z tablicą wynikową
    if !self.is_a?(Array)
      return [self]
    end

    outputArray = []
    self.my_each do |element|
      if !element.is_a?(Array)
        outputArray << element
      else
        # concat
        outputArray += element.my_flatten
      end
    end

    outputArray
  end

  def my_zip(*inputArrays)
    inputArgsLength = inputArrays.length
    zippedArr = Array.new(inputArgsLength + 1) { Array.new() }

    self.each_with_index do |element, index|
      zippedArr[index] << element
    end

    zippedArr.length.times do |index|
      inputArrays.each do |inputArray|
        zippedArr[index] << inputArray[index]
      end
    end

    zippedArr
  end

  def my_rotate(num = 1)
    rotated_arr = self.dup
    if num > 0
      num.times do
        element = rotated_arr.shift
        rotated_arr << element
      end
    else
      num.abs.times do
        element = rotated_arr.pop
        rotated_arr.unshift element
      end
    end

    #     split_idx = positions % self.length

    # self.drop(split_idx) + self.take(split_idx)

    rotated_arr
  end

  def my_join(separator = "")
    joined_elements = ""
    if separator == ""
      self.each do |element|
        joined_elements += element
      end
    else
      self.each do |element|
        joined_elements += element + separator
      end
      joined_elements = joined_elements.chop
    end

    joined_elements
  end

  def my_reverse
    reversed_array = []
    self.each { |element| reversed_array.unshift(element) }

    reversed_array
  end
end

def prime?(num)
  #   debugger
  (2..num / 2).each do |factor|
    return false if num % factor == 0
  end

  true
end

def factors(num)
  factors = []
  primes = []
  half_size = num / 2.0
  #   debugger
  (2..half_size).each do |factor|
    if prime?(factor)
      primes << factor
    end
  end
  #   debugger
  primes.each do |prime|
    (2...half_size).each do |factor|
      if prime * factor == num
        factors << factor << prime
      end
    end
  end

  factors << 1 << num
  factors.sort
end

def subwords(word, dictionary)
  subwords = []
  dictionary.each do |dictionary_word|
    if word.include?(dictionary_word)
      subwords << dictionary_word
    end
  end
  subwords.uniq
end

#   expect(words).to eq(["cat"])
#   words = subwords("bombawpiwnicy", ["bomba", "w", "piwnic"])
#   words = subwords("asdfcatqwer", ["cat", "car"])

# p prime?(10)
# p factors(12345)

class Array
  def bubble_sort!(&prc)
    prc ||= Proc.new { |prevEl, nextEl| prevEl <=> nextEl }
    is_sorted = false

    while !is_sorted
      is_sorted = true

      (0...self.length - 1).each do |index|
        previousElem, nextElem = self[index], self[index + 1]
        # debugger
        if prc.call(previousElem, nextElem) == 1
          self[index], self[index + 1] = self[index + 1], self[index]
          is_sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    sorted_arr = self.dup
    # debugger
    sorted_arr.bubble_sort!(&prc)
  end
end

# a = [12, 8, 13]
# a.bubble_sort => 8, 12, 13
# a = [12, 8, 13]
#
# Write a method, String#substrings, that takes in a optional length argument
# The method should return an array of the substrings that have the given length.
# If no length is given, return all substrings.
#
# Examples:
#
# "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
# "cats".substrings(2)  # => ["ca", "at", "ts"]
# class String
def substrings(string)
  substringsCollection = []
  (0...string.length).each do |beginning|
    (beginning...string.length).each do |ending|
      substringsCollection << string[beginning..ending]
    end
  end

  substringsCollection
end

# end
