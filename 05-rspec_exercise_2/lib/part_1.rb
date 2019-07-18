def partition(arr, num)
  partition = partition = Array.new(2) {Array.new()}
  arr.each do |val|
    if val < num
      partition[0] << val
    else
      partition[1] << val
    end
  end
  partition
end

def merge(hash1, hash2)
  merged = Hash.new()
  hash1.each { |k, v| merged[k] = v } 
  hash2.each { |k, v| merged[k] = v}
  merged
end

def censor(sentence, curses)
  vowels = "aeiou"
  
  cleanSentence = sentence.split.map do |word|
    if curses.include?(word.downcase)
      word.each_char.with_index do |char, i|
         word[i] = '*' if vowels.include?(char.downcase)
      end
    end

    word
  end
  cleanSentence.join(' ')
  
end

def power_of_two?(num)

  while( num != 1)
      # checks whether a number is divisible by 2
      return false if num % 2 != 0
      num /= 2.0;
  end
  true
end