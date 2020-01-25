# frozen_string_literal: true

class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    #  The trick here will be to create a scheme to convert instances of each class
    # to a Integer and then apply this hashing function.
    #  This can be used on Numerics such as the index of an array element.
    # convert to integer

    # [3, 4, 5].each_with_index.inject(0) { |sum, (value, index)| sum + value * index } #=> 14

    arrHash = each_with_index.inject(0) do |hash, (value, idx)|
      # if hash.zero?
      #   (value.to_s.to_i * idx + 1).to_s(2).to_i(2)
      # else
      #   (hash ^ (value.to_s.to_i * idx)).to_s(2).to_i(2)
      # end
      (value.hash + idx.hash) ^ hash
    end

    arrHash.hash
  end
end

class String
  # Can you write String#hash in terms of Array#hash?
  def hash
    split('').map(&:ord).hash
    # chars == split('')
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method

  # When you get to hashing hashes: one trick to make a hash function order-agnostic is
  #  to turn the object into an array, stably sort the array, and then hash the array.
  # This'll make it so every unordered version of that same object will hash to the same value.
  def hash
    to_a.map(&:hash).sum.hash
  end
end
