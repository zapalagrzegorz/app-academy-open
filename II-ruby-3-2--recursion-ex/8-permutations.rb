# require "byebug"
# # [].permu

# # []
# # Similar to the subsets problem, we observe that to get the permutations
# # of [1, 2, 3] we can look at the permutations of [1, 2] which are
# # [1, 2] and [2, 1] and add the last element to every possible index getting
# # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1]

# # def permutations(arr)
# #   arr if arr.empty? || arr.length == 1
# #   #   debugger
# #   arr.each_with_index do |element, index|
# #     arr[0], arr[arr.count - 1] = arr.last, arr.first
# #     # p arr

# #     arr = permutations(arr.take(arr.count - 1))
# #     arr[0], arr[arr.count - 1] = arr.last, arr.first
# #   end
# # end

# # permutations([1])

# def permutations(array)
#   return [array] if array.length <= 1

#   # Similar to the subsets problem, we observe that to get the permutations
#   # of [1, 2, 3] we can look at the permutations of [1, 2] which are
#   # [1, 2] and [2, 1] and add the last element to every possible index getting
#   # [3, 1, 2], [1, 3, 2], [1, 2, 3], [3, 2, 1], [2, 3, 1]

#   # pop off the last element
#   first = array.shift
#   # make the recursive call
#   perms = permutations(array)
#   # we will need an array to store all our different permutations
#   total_permutations = []

#   # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
#   # and for each permutation add first into every index. This new subarray
#   # gets added to total_permutations.
#   perms.each do |perm|
#     (0..perm.length).each do |i|
#       total_permutations << perm[0...i] + [first] + perm[i..-1]
#     end
#   end
#   total_permutations
# end

# [1]
# [[1]]

# [1,2]
# [[1,2], [2,1]]

# [1,2]

# [1]

def permutations(array)
  return [array] if array.length <= 1

  #   # pop off the last element
  # first = array.shift

  #  make the recursive call

  # take the base and join with the rest
  perms = permutations(array.take(array.count - 1))
  # dla permutacji [1,2,3]

  # wiemy, że permutacja([2,3]) -> [[2,3],[3,2]]
  # first = 1
  # perms = [[2,3],[3,2]]

  #   # we will need an array to store all our different permutations
  total_permutations = []
  # dla [1,2] perms -> [[2]]

  # Now we iterate over the result of our recusive call say [[1, 2], [2, 1]]
  # and for each permutation add first into every index. This new subarray
  # gets added to total_permutations.

  # perms = [[2]]

  # dla permutations([1,2,3])
  # mamy:
  # first = 1
  # perms = [[2,3],[3,2]]
  perms.each do |perm|
    # perm [2]2

    (0..perm.length).each do |i|
      # dla każdego indeksu permutacji dodaj pierwszy element
      # 0..1
      # perm[0...0] -> []
      # first -> 1
      # perm[0..-1] ->
      # if i == 0 total_permutations << [first] + perm[i..-1]
      # if i == perm.length total_permutations << [first] + perm[i..-1]

      total_permutations << perm[0...i] + [arr.last] + perm[i..-1]
      # [] + [1] + [2] -> [1,2]

      # dla i = 1
      # perm[0...1] -> [2]
      # [first] -> [1]
      # perm[1..-1]
    end
  end

  total_permutations
end
