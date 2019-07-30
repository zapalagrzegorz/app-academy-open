def hipsterfy(word)
    vowels = "aeiou"

    i = word.length - 1
    
    while i >= 0
        if vowels.include?(word[i])
            # word[i] = ''
            return word[0...i] + word[i+1..-1]
            return word
        end 

        i -= 1
    end

    word
end

def vowel_counts(string)
    vowels = ["a", "e", "i", "o", "u"]
    hash = Hash.new(0)
    string.each_char do |char|
        hash[char.downcase] += 1 if vowels.include?(char.downcase)
    end
    hash
end


def caesar_cipher(msg, num)
    #   alphabet = ("a".."z").to_a
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    encoded = ''
  
    msg.each_char do |char|
        charIndex = alphabet.index(char)
        if charIndex != nil
            index = (charIndex + num ) % alphabet.length
            encoded += alphabet[index]
        else
            encoded += char
        end
    end
  return encoded
end