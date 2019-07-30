def palindrome?(word)
  i = word.length-1
  j = 0
  while j < word.length
    return false if word[i] != word[j] 
      
    i -= 1
    j += 1

  end
  
  return true

end

def substrings(string)
  substrings = []
  (0...string.length).each do |i|
    (0...string.length).each do |j|
      substrings << string[i..j] if j >= i
    end
  end 
  substrings
end

def palindrome_substrings (somestring)
  substrs = substrings(somestring)
  allPalindromes = substrs.select {|word| palindrome?(word) }
  allPalindromes.select { |word| word.length > 1 }
end