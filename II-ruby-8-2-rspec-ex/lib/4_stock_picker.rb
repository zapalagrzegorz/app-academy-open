# frozen_string_literal: true

require 'byebug'

class Stock_picker
  def initialize(stock_arr)
    @stock_arr = stock_arr
    validate_stock
  end

  def pick_stocks
    best_deal_days(profitable_deals)
  end

  private

  def validate_stock
    raise ArgumentError unless @stock_arr.is_a?(Array) && @stock_arr.length > 1

    @stock_arr.each do |stock_entry|
      raise ArgumentError unless stock_entry.is_a?(Hash)

      stock_entry.values.each do |value|
        raise ArgumentError unless value.is_a?(Numeric)
      end
    end
  end

  def profitable_deals
    profits = []
    @stock_arr.each_with_index do |buy, buy_idx|
      @stock_arr.each_with_index do |sell, sell_idx|
        next if sell_idx <= buy_idx

        diff = (sell.values[0] - buy.values[0])
        profit = diff.positive?
        profits << [diff, [buy_idx, sell_idx]] if profit
      end
    end

    profits
  end

  def best_deal_days(deals)
    best_deal = deals.inject do |highest, arr|
      arr if arr[0] > highest[0]
    end

    best_deal[1]
  end
end

# [{ "enea": 18.0 },
#  { "enea": 19.0 },
#  { "enea": 17.0 },
#  { "enea": 20.1 }]

# [[0, 1], [2, 3]]
# "key" : value

# [1, [0, 1]]
# [3, 1, [2, 3]]
