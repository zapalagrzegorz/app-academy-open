# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def countConsecutiveChars(char, idx)


    # {char: char, :idx: idx}
    # 3a
end

def compress_str(string)
    # streakValue = 0
    # streakStart = 0
    # streakEnd = 0
    # idx = 0
    
    # compressed = ''
    
    # char = string[0] 
    # streakLen = 1
    # idx = 1

    # if string[0] == string[1]
    compressed = ''
    counter = 1
    idx = 0
       # aaabbc
    while idx < string.length
        while string[idx] == string[idx+1]
            counter += 1
            idx += 1
        end

        if counter > 1
            compressed += counter.to_s + string[idx]
        else
            compressed += string[idx]
        end
        counter = 1
        idx += 1
    end

    compressed

end

p compress_str("aaabbc")        # => "3a2bc"
 p compress_str("xxyyyyzz")      # => "2x4y2z"
 p compress_str("qqqqq")         # => "5q"
 p compress_str("mississippi")   # => "mi2si2si2pi"
