# frozen_string_literal: true

def my_transpose(arr)
  raise ArgumentError unless arr.is_a?(Array)

  transposed = Array.new(arr.length) { Array.new(arr.length) }

  arr.each_with_index do |row, row_idx|
    row.each_with_index do |element, col_idx|
      transposed[col_idx][row_idx] = element
    end
  end

  transposed
end
