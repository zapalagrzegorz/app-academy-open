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
