# frozen_string_literal: true

# two_sum?
# Given an array of unique integers and a target sum,
# determine whether any two
#  integers in the array sum to that amount.
require 'byebug'

arr = [0, 1, 5, 7]

# time O(n^2)
def bad_two_sum?(arr, target_sum)
  arr.each_with_index do |element, idx|
    arr.each_with_index do |second_element, sec_idx|
      next if idx == sec_idx

      return true if element + second_element == target_sum
    end
  end

  false
end

# your code here...
# target

# typowy n^2 time - każdy z każdym bez samego siebie
# space

# sortowanie?
# wprowadza dolną granicą złożoności czasowej odpowiadajacej złożoności algorytmu sortowania
# od n*log(n) do n^2
# można odrzucić liczby, które są większe niz target,
#  zakładając nie ma liczb ujemnych
def okay_two_sum?(arr, target_sum)
  cut_arr = arr
  reversed_arr_idxs = (0...cut_arr.length).to_a.reverse

  # two_sum
  cut_arr.each_with_index do |ele, idx|
    # debugger if ele == 5 || ele == 1
    reversed_arr_idxs.each do |rev_idx|
      next if idx == rev_idx
      # najmniejszy + największy jest wciąz mniejszy niż szukany, to należy
      # zwiększyć najmniejszy
      break if ele + cut_arr[rev_idx] < target_sum

      return true if ele + cut_arr[rev_idx] == target_sum
    end
  end
  #   (cut_arr.length...0).times {}
  #   # cut_arr.each_with_index do |sec_el, idx|
  #   end
  # end
  false
end

# Hash Map

# Finally, it's time to bust out the big guns: a hash map. Remember, a hash map has O(1) #set and O(1) #get, so you can build a hash out of each of the n elements in your array in O(n) time. That hash map prevents you from having to repeatedly find values in the array; now you can just look them up instantly.

# See if you can solve the two_sum? problem in linear time now, using your hash map.

# Once you're finished, make sure you understand the time complexity of your solutions and then call over your TA and show them what you've got. Defend to them why each of your solutions has the time complexity you claim it does.

def hash_two_sum?(arr, target_sum)
  int_hash = {}
  arr.each do |val|
    # debugger if int_hash[target_sum - val]
    return true if int_hash[target_sum - val]

    int_hash[val] = val
  end

  false
end

# 10
# 9,1; 8,2; 7,3; 4,6

puts bad_two_sum?(arr, 6) ? 'correct' : 'false' # => should be true
puts bad_two_sum?(arr, 10) ? 'false' : 'correct' # => should be false

# debugger
puts okay_two_sum?(arr, 6) ? 'correct' : 'false' # => should be true
puts okay_two_sum?(arr, 10) ? 'false' : 'correct' # => should be false

puts hash_two_sum?(arr, 6) ? 'correct' : 'false' # => should be true
puts hash_two_sum?(arr, 10) ? 'false' : 'correct' # => should be false

# p hash_two_sum?(arr, 10)
