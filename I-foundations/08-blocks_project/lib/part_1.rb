# frozen_string_literal: true

def select_even_nums(numArr)
  numArr.select(&:even?)
end

def reject_puppies(arrHash)
  arrHash.reject { |dog| dog['age'] <= 2 }
end

# #count
# If a block is given, it counts the number of elements yielding a true value.
def count_positive_subarrays(arr2d)
  arr2d.count { |el| el.sum > 0 }
end

def aba_translate(string)
  encoded = ''

  string.each_char do |char|
    encoded += if 'aeuoi'.include?(char)
                 char + 'b' + char
               else
                 char
               end
  end

  encoded
end

def aba_array(arrWords)
  arrWords.map { |word| aba_translate(word) }
end
