# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require 'byebug'

def prime?(num)

    return false if num < 2

    # zwróć true gdy żaden element nie spełnia warunku
    # If the block is not given, none? will return true only if none of the collection members is true.
    # (2...num).none?{ |factor| num % factor == 0}  
    (2...num).each do |factor|
        return false if num % factor == 0
    end
    true
end

def largest_prime_factor(num)
    # prime number
    #   num.downto(2)
  (2..num).reverse_each do |divisor|
    if num % divisor == 0 && prime?(divisor)
      return divisor
    end
  end


end

def unique_chars?(string)
    #   cache
    #   already_seen = []

    # string.each_char do |char|
    #     return false if already_seen.include?(char)
    #     already_seen << char
    # end

    # true
  (0...string.length).each do |start_idx|
    (start_idx+1...string.length-1).each do |end_idx|
      if string[start_idx] == string[end_idx]
        return false
      end
    end
  end
  
  true
end


# isDuplicate
# czy jest na dalszym indeksie
# array.each_with_index do |char|
#   array.include?(char)
# end
def dupe_indices(array)
    
    #   ["a", "a", "c", "c", "b", "c"])).to eq({"a"=>[0,1], "c"=>[2,3,5]}
  
    # domyślna wartość dla klucza hash'a to tablica
    # indices = Hash.new { |h, k| h[k] = [] }
    # array.each_with_index { |ele, i| indices[ele] << i }
    # hash = {}

    # array.each_with_index do |elem, idx|
    #     if hash[elem] == nil 
    #         hash[elem] = [idx]
    #     else
    #         hash[elem] << idx
    #     end
    # end
    # na Hash'u można puścić select (filter)!
    # hash.select { |k, v| v.length > 1}

    hash = {}
    array.each_with_index do |ele, idx|
        if hash[elem] == nil 
            hash[elem] = [idx]
        else
            hash[elem] << idx
        end
    end    
    (0...array.length).each do |start_idx|
    
    arr = []
    # początkowy element
    char = array[start_idx] 
      
      # kolejne elementy
      (start_idx+1...array.length).each do |end_idx|
      
        # znajdź duplikat
        if char == array[end_idx]
          
          # pierwsze wystąpienie
          if hash[char] == nil
            hash[char] = [start_idx, end_idx] 
          else
            # kolejne wystąpienia - dodaj tylko gdy indeksu nie odnotowano
            hash[char] << end_idx if !hash[char].include?(end_idx)
          end
        end
      end
  end
  
  hash
end

# debugger
# dupe_indices(["a", "b", "c", "c", "b"])

def ana_array(arr1, arr2)
  hash = Hash.new(0)
  hash2 = Hash.new(0)
  
    # DRY - make this separate function   
  arr1.each  do |el|
    hash[el] += 1
  end


  arr2.each  do |el|
    hash2[el] += 1
  end

  hash == hash2
end