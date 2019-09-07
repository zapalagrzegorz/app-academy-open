# this is math, not Ruby methods.

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exp(base, power)
  return 0 if base == 0

  return 1 if (power == 0)

  base * exp(base, power - 1)
end

# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]

def exp2(base, power)
  return 0 if base == 0

  return 1 if (power == 0)

  return base if power == 1

  if (power.even?)
    smaller_exponent = power / 2

    exp(base, smaller_exponent) * exp(base, smaller_exponent)
  else
    smaller_exponent = (power - 1) / 2

    base * exp(base, smaller_exponent) * exp(base, smaller_exponent)
  end
end
