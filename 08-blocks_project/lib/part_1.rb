def select_even_nums(numArr)
  numArr.select(&:even?)
end

def reject_puppies(arrHash)
  arrHash.reject { |dog| dog['age'] <= 2 }
end

def count_positive_subarrays(arr2d)
  arr2d.count { |el| el.sum > 0 }
end

def aba_translate(string)
  encoded = ''
  
  string.each_char do |char| 
    if 'aeuoi'.include?(char)
      encoded += char + "b" + char
    else
      encoded += char
    end
  end

  encoded
end

def aba_array(arrWords)
  arrWords.map { |word| aba_translate(word) }
end

