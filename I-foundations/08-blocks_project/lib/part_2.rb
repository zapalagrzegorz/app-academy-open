def all_words_capitalized?(arrWords)
  arrWords.all? do |word|
    word[0] == word[0].upcase && word[1...word.length] == word[1...word.length].downcase
    # word.capitalize == word }
    # (1...word.length).each {|idx| word[idx] ==  word[idx].downcase }
  end
end

def no_valid_url?(arrURLs)
  valid_endings = [".com", ".net", ".io", ".org"]
  # arrURLs.none? do |url|
  #  end_with?()
  arrURLs.none? do |url|
    url.end_with?(*valid_endings)
    # url.include?('.com') || url.include?('.net') || url.include?('.io') || url.include?('.org')
  end
end

def any_passing_students?(students)
  students.any? { |student|
    (student[:grades].sum / student[:grades].length * 1.0) >= 75
  }
end
