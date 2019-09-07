# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.

def iFibonacci(fibonaciNums)
  return [] if fibonaciNums == 0

  return [0] if fibonaciNums == 1

  fibArr = [0]
  num1 = 0
  num2 = 1

  fibonaciNums.times do
    fibArr << num1 + num2

    num2 += num1
    num1 = num2 - num1
  end

  fibArr
end
