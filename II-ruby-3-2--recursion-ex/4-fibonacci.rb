# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.

def iFibonacci(fibonaciNums)
  return [] if fibonaciNums == 0

  return [0] if fibonaciNums == 1

  return [0, 1] if fibonaciNums == 2

  fibArr = [0, 1]
  num1 = fibArr.first
  num2 = fibArr.last

  fibonaciNums.times do
    fibArr << num1 + num2

    num2 += num1
    num1 = num2 - num1
  end

  fibArr
end

def rFibonacci(fibonaciNums)
  return [] if fibonaciNums == 0

  return [0] if fibonaciNums == 1

  return [0, 1] if fibonaciNums == 2

  return [0, 1, 1] if fibonaciNums == 3

  fibArr = rFibonacci(fibonaciNums - 1) # rFib(4) => [0,1,1]
  nextFibNum = fibArr[-1] + fibArr[-2] # rFib(4) => [0,1,1] + 1 + 1
  # num2 = 1

  fibArr << nextFibNum
end

p rFibonacci(7)
