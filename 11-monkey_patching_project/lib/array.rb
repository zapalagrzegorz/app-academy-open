# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    if self.empty?
      return nil
    else
      # self.max - self.min
      largest = self[0]
      smallest = self[0]
      (1...self.length).each do |idx|
        largest = self[idx] if self[idx] > largest
        smallest = self[idx] if self[idx] < smallest
      end
    end

    largest - smallest
  end

  def average
    if self.empty?
      nil
    else
      self.sum / (self.length * 1.0)
      # self.sum / self.length.to_f
    end
  end

  def median

    #  return nil if self.empty?

    # mid_index = self.length / 2
    # sorted = self.sort
    if self.empty?
      nil
    elsif self.length.odd?
      self.sort[self.length / 2]
    else
      num1 = self.sort[self.length / 2]
      num2 = self.sort[(self.length / 2) - 1]

      (num1 + num2) / 2.0
    end
  end

  def counts
    count = Hash.new(0)
    self.each { |val| count[val] += 1 }
    count
  end

  def my_count(value)
    count = 0
    self.each { |val| count += 1 if val == value }
    count
  end

  def my_index(value)
    self.each_with_index { |v, idx| return idx if v == value }

    return nil
  end

  def my_uniq
    # można wykorzystać istotę hasha - który zbiera unikalne klucze
    # elements = {}
    #     self.each { |ele| elements[ele] = true }
    #     elements.keys

    count = self.counts
    self.select.with_index do |arrValue, idx|
      if count[arrValue] == 1
        arrValue
      elsif self.index(arrValue) == idx
        arrValue
      end
    end
  end

  def my_transpose
    transpose = []
    rowIdx = 0

    while rowIdx < self[0].length
      column = []

      self.each do |row|
        column << row[rowIdx]
      end

      transpose << column
      rowIdx += 1
    end

    transpose
  end
end
