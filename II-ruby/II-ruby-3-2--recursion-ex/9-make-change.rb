require "byebug"

def greedy_make_change(change, coins)
  rest = []
  coin = coins.first

  coins_number = change / coin
  coins_number.times { rest << coin }
  change -= coins_number * coin

  if (change > 0)
    rest += greedy_make_change(change, coins.drop(1))
  end

  rest
end

# greedy_make_change(24, [10, 7, 1])
# 10, 7, 7

# dla trzech monet będą zasadniczo trzy rozwiązania
# każda z trzech monet występuje na pierwszym poziomie kodu
#   zakładając, że można zbudować resztę używając każdej z trzech początkowych dróg
# początkowych rozwiązań - kod trzy razy dojdzie wyznaczy wartości reszty

# tą resztę porównujemy z zewnętrzną zmienną - best_change

# każda z monet daje rest + reszta po odjęciu danej monety
def make_better_change(change, coins)
  return [] if change == 0

  best_change = nil

  coins.each do |coin|
    next if coin > change

    subproblem = make_better_change(change - coin, coins)
    rest = [coin] + subproblem

    if best_change.nil? || rest.count < best_change.count
      best_change = rest
    end
  end

  best_change
end
