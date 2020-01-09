# frozen_string_literal: true

fish = %w[fish fiiish fiiiiish fiiiish fffish ffiiiiisshh fsh fiiiissshhhhhh]

fishes = %w[fish fiiish fiiiiish fiiiish fffish ffiiiiisshh fsh fiiiissshhhhhh]

def sluggish_octopus(fish)
  longest = ''
  fish.each do |item|
    fish.each do |inner_item|
      long = item.length > inner_item.length ? item : inner_item
      longest = longest.length > long.length ? longest : long
    end
  end

  longest
end

p sluggish_octopus(fish)

def clever_octopus(fish)
  longest = ''
  fish.each do |item|
    longest = item if item.length > longest.length
  end

  longest
end

def quadratic_biggest_fish(fishes)
  fishes.each_with_index do |fish1, i1|
    max_length = true

    fishes.each_with_index do |fish2, i2|
      next if i1 == i2

      max_length = false if fish2.length > fish1.length
    end

    return fish1 if max_length
  end
end

p clever_octopus(fish)

puts 'quadratic:'
p quadratic_biggest_fish(fish)
