# frozen_string_literal: true

tiles_array = %w[up right-up right right-down down left-down left left-up]

def slow_dance(key, arr)
  arr.each_with_index do |item, idx|
    return idx if item == key
  end
end

p slow_dance('right-down', tiles_array)

moves_hash = {
  "up": 0,
  "right-up": 1,
  "right": 2,
  "right-down": 3,
  "down": 4,
  "left-down": 5,
  "left": 6,
  "left-up": 7
}

def fast_dance(key, hash)
  hash[key.to_sym]
end

p fast_dance('up', moves_hash)
