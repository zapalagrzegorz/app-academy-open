# frozen_string_literal: true

require 'rspec'
require 'dessert'

# Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.

describe Dessert do
  let(:chef) { double('chef', titleize: 'Greg the Great') }
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
      ingredients = %w[pomidor cebula czosnek sól]

      ingredients.each { |ingredient| dessert.add_ingredient(ingredient) }

      expect(dessert.ingredients).to start_with('pomidor')

      dessert.mix!
      ##
      # how to test shuffle

      expect(dessert.ingredients).not_to eq(ingredients)
      expect(dessert.ingredients.sort).to eq(ingredients.sort)
    end
  end

  describe '#eat' do
    it 'subtracts an amount from the quantity' do
      dessert.eat(2)
      expect(dessert.quantity).to be_zero
    end

    it 'raises an error if the amount is greater than the quantity' do
      expect { dessert.eat(3) }.to raise_error('not enough left!')
    end
  end

  describe '#serve' do
    it "contains the titleized version of the chef's name" do
      # expect(customer).to receive(:debit_account).with(5.99)
      # expect(chef).to receive(:titleize)
      expect(dessert.serve).to eq('Greg the Great has made 2 makowiecs!')
    end
  end

  describe '#make_more' do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
