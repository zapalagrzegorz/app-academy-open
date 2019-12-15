# frozen_string_literal: true

# Stock Picker

# Write a method that takes an array of stock prices (prices on days 0, 1, ...), and outputs the most profitable pair of days on which to first buy the stock and then sell the stock. Remember, you can't sell stock before you buy it!

require '4_stock_picker'

describe 'Stock_picker' do
  let(:stocks) do
    [{ "enea": 21.0 }, { "enea": 19.0 }, { "enea": 17.0 }, { "enea": 20.1 }]
  end

  subject(:stock_picker) { Stock_picker.new(stocks) }

  it 'accepts array of stocks' do
    expect { Stock_picker.new }.to raise_error ArgumentError
    expect { Stock_picker.new([]) }.to raise_error ArgumentError
    expect { Stock_picker.new([{ "key": 1 }]) }.to raise_error ArgumentError
    expect { Stock_picker.new(stocks) }.not_to raise_error
  end

  context 'when returns' do
    it 'is an array' do
      expect(stock_picker.pick_stocks.is_a?(Array)).to be(true)
    end

    it 'is pair of days' do
      expect(stock_picker.pick_stocks.length).to eq(2)
    end

    it 'the most profitable pair' do
      expect(stock_picker.pick_stocks).to eq([2, 3])
    end
  end
end
