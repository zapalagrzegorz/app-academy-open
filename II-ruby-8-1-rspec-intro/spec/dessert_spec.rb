# frozen_string_literal: true

require 'rspec'
require 'dessert'

# Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.

describe Dessert do
  let(:chef) { double('chef') }
  subject(:dessert) { Dessert.new('makowiec', 2, chef) }

  describe '#initialize' do
    it 'sets a type' do
      expect(dessert.type).to eq('makowiec')
    end

    it 'sets a quantity' do
      expect(dessert.quantity).to eq(2)
    end

    # expect(Array.empty?).to be true is equivalent to expect(Array).to be_empty.
    it 'starts ingredients as an empty array' do
      expect(dessert.ingredients).to be_empty
    end

    it 'raises an argument error when given a non-integer quantity' do
      expect { Dessert.new('makowiec', 'number', chef) }.to raise_error(ArgumentError)
    end
  end

  describe '#add_ingredient' do
    it 'adds an ingredient to the ingredients array' do
      dessert.add_ingredient('pomidor')
      expect(dessert.ingredients).to include('pomidor')
    end
  end

  describe '#mix!' do
    it 'shuffles the ingredient array' do
      dessert.add_ingredient('pomidor')
      dessert.add_ingredient('cebula')
      dessert.add_ingredient('czosnek')
      dessert.add_ingredient('sól')
      expect(dessert.ingredients).to start_with('pomidor')

      dessert.mix!
      ##
      # how to test shuffle

      expect(dessert.ingredients).not_to eq(%w[pomidor cebula czosnek sól])
    end
  end

  describe '#eat' do
    it 'subtracts an amount from the quantity'

    it 'raises an error if the amount is greater than the quantity'
  end

  describe '#serve' do
    it "contains the titleized version of the chef's name"
  end

  describe '#make_more' do
    it "calls bake on the dessert's chef with the dessert passed in"
  end
end
