def average(num1, num2)
    if !(num1.is_a?(Integer) && num2.is_a?(Integer))
    end
    
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum / (arr.length.to_f) 
end

def repeat(str, num)
    str*num
end

def yell(str)
    str.upcase + '!'
end

def alternating_case(str)
    # alternated = []
    words = str.split(' ')
    alternated = words.map.with_index do |word, i|
        if i.even?
            word.upcase
        else
            word.downcase
        end
    end
    alternated.join(' ')
end