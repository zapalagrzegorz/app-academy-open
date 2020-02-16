# frozen_string_literal: true

# My Transpose

# To represent a matrix, or two-dimensional grid of numbers, we can write an array containing arrays which represent rows:

# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]

# row1 = rows[0]
# row2 = rows[1]
# row3 = rows[2]

# We could equivalently have stored the matrix as an array of columns:

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]

# Write a method, my_transpose, which will convert between the row-oriented and column-oriented representations. You may assume square matrices for simplicity's sake. Usage will look like the following:

# my_transpose([
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ])

# => [[0, 3, 6],
#    [1, 4, 7],
#    [2, 5, 8]]

require '3_my_transpose'

describe '#my_transpose' do
  let(:arr) do
    [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]
  end

  it 'requires arrays as argument' do
    expect { my_transpose }.to raise_error ArgumentError
    expect { my_transpose(arr) }.not_to raise_error
  end

  it 'returns array' do
    expect(my_transpose(arr)).to be_an(Array)
  end

  it 'returns transposed array' do
    expect(my_transpose(arr)).to eq([[0, 3, 6],
                                     [1, 4, 7],
                                     [2, 5, 8]])
  end
end
