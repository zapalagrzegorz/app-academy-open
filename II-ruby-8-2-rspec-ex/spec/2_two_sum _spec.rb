# frozen_string_literal: true

require 'rspec'
require '2_two_sum'
# Two sum

# Write a new Array#two_sum method that finds all pairs of positions where the elements at those positions sum to zero.

# NB: ordering matters. We want each of the pairs to be sorted smaller index before bigger index. We want the array of pairs to be sorted "dictionary-wise":

# [-1, 0, 2, -2, 1].two_sum # => [[0, 4], [2, 3]]

#     [0, 2] before [2, 1] (smaller first elements come first)
#     [0, 1] before [0, 2] (then smaller second elements come first)

describe '#two_sum' do
  let(:arr) { [-1, 0, 2, -2, 1] }

  it 'exists' do
    expect { arr.two_sum }.not_to raise_error
  end

  it 'returns array' do
    expect(arr.two_sum).to be_an(Array)
  end

  it 'returns sorted pairs of index' do
    expect(arr.two_sum).to eq([[0, 4], [2, 3]])
  end
end
