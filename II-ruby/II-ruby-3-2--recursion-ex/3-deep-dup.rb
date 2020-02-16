require "byebug"
# Deep dup
# The #dup method doesn't make a deep copy:

# Using recursion and the is_a? method, write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

# You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].

# [1]
def deep_dup(arr)
  return [] if arr.length.zero?

  innerArr = []

  arr.each do |el|
    if el.is_a?(Array)
      innerArr << deep_dup(el)
    else
      innerArr << el
    end
  end

  innerArr
end

deep_dup([1])
