# frozen_string_literal: true

# [1,2]
require 'byebug'
def permutations(array)
  return [array] if array.length <= 1

  #  make the recursive call
  # take the base and join with the rest

  ## dla tablicy trzy elementowej [1,2,3] zwróci [1,2], a dalej [1]
  # permutacja [1,2] -> [[1,2],[2,1]]

  perms = permutations(array[0...-1])
  # dla permutacji [1,2,3]
  # first = 1
  # pierwszy wynik perms to [1]
  ## wiemy, też zakładając, że wywołanie rekursywne działa,
  ##  że permutacja([2,3]) -> [[2,3],[3,2]]
  ## perms = [[2,3],[3,2]]

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

    # dla każdego indeksu permutacji dodaj pierwszy element
    # dla tablicy [1], indeksy są 0 oraz 1
    # (0..perm.length) -> 0..1 - 0,1
    (0..perm.length).each do |i|
      # perm[0...i]
      # dla indeksu zerowego, zwróć pustą tablicę
      # dla indeksu końcowego, weź wszystkie
      # z drugiej strony łącz drugi koniec tablicy:
      # perm[i..-1] (czyli weź element indeksu i policz do końca)
      # dla indeksu zerowego oznacza weź wszystko
      # dla indeksu końcowego zwróć pustą tablicę
      #
      # tak iterując podpinaj 'po środku' dodatkowy element
      total_permutations << perm[0...i] + [array.last] + perm[i..-1]
    end
  end

  total_permutations
end
