# frozen_string_literal: true

require 'rspec'
require '1_remove_dups'

# Write your own version of this method called my_uniq; it should take in an Array and return a new array.

describe '#my_uniq' do
  let(:arr) { [1, 2, 3, 4, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1, 3, 4, 5, 4, 3, 2] }
  it 'throws error when given not array' do
    expect { my_uniq({}) }.to raise_error(ArgumentError)
    expect { my_uniq(1) }.to raise_error(ArgumentError)
    expect { my_uniq('array') }.to raise_error(ArgumentError)
    expect { my_uniq(true) }.to raise_error(ArgumentError)
    expect { my_uniq(nil) }.to raise_error(ArgumentError)
  end

  it 'takes an Array' do
    expect { my_uniq([]) }.not_to raise_error
  end

  # it "removes duplicates" do
  it 'returns uniq Array' do
    expect(my_uniq(arr)).to eq([1, 2, 3, 4, 5])
  end

  #  it "only contains items from original array" do
  #     uniqued_array.each do |item|
  #       expect(array).to include(item)
  #     end
  #   end

  # it "does not modify original array" do
  #   expect {
  #     my_uniq(array)
  #   }.to_not change{array}
  # end

  context 'when given empty array' do
    it 'returns empty array' do
      expect(my_uniq([])).to eq([])
    end
  end
end
