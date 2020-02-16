# frozen_string_literal: true

require_relative '5_minmaxstack'

# skoro klasa jest hybrydą klass StackQueue oraz MinMaxStack
# to powinna implementować metody obu klas... a przynajmniej te, które się nie powtrzają
# dodawania jest do kolejki więc nie ma pop/push => enqueue oraz dequeue
# + max/min z MinMaxStack

class MinMaxStackQueue
  def initialize
    # @store =
    @in_stack = MinMaxStack.new
    @out_stack = MinMaxStack.new
  end

  def size
    @in_stack.size + @out_stack.size
  end

  def empty?
    @in_stack.empty? && @out_stack.empty?
  end

  def enqueue
    @in_stack.push(val)
  end

  def dequeque
    queueify if @out_stack.empty?
    # If we haven't already reversed the stack, this runs in O(n). However, we
    # only have to do this once for every n dequeue operations, so it amortizes
    # to O(1)
    @out_stack.pop
  end

  def max
    # At most two operations; O(1)
    # dwie operacje, ale kosztują przecież (n)
    maxes = []
    maxes << @in_stack.max unless @in_stack.empty?
    maxes << @out_stack.max unless @out_stack.empty?
    maxes.max
  end

  def min
    mins = []
    mins << @in_stack.min unless @in_stack.empty?
    mins << @out_stack.min unless @out_stack.empty?
    mins.min
  end

  private

  def queueify
    # How do you turn a stack into a queue? Flip it upside down.
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end
end

# - windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# jeżeli będę zapisywać kolejkując (enqueue), to efekt mam taki:
# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
# 4 (max: 5, min: 0)
# 8 (max: 8, min: 0)

# teraz zamieniając kolejkę na stos efekt będzie taki
# zakładajac, że zapisuję kolejkując
# 8 (max: 8, min: 0)
# 4 (max: 8, min: 0) - to
# [8,4,5,2,0,1]
# [8 (max: 8, min: 8),4 (max: 8, min: 4), 5(max:8, min: 4)]
# nie wiem jak struktura kolejki opartej na dwóch stosach ma pomóc przy stałej
# zmianie okna (2 elementowego) mając dwa elementy na out_stack, chciałbym w
# efektywny sposób usunąć dolny elementy stosu i porównać kolejne dwa element

# inaczej wartości sprawdzam

# inna wątpliwość
# jeżeli bym okno obserwowała na etapie kolejkowania, to też nie wiem jak stos ma mi pomóc

# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# różnica 1
# okno ma dwa elementy i co teraz mam usunąć z kolejki?
# wówczas mam
## in_queue: [1, max:1, min:0]
## nowa_kolejka : [0, max:1, min:0]

# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
# 4 (max: 5, min: 0)
# 8 (max: 8, min: 0)

# eureka?

# stara kolejka
# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
# 4 (max: 5, min: 0)
# 8 (max: 8, min: 0)
#
###
# nowa kolejka:
# []

# stara kolejka
# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
# 4 (max: 5, min: 0)
#
#

# nowa kolejka:
# [ 8 (max: 8, min: 0)] - size nie jest dwa, dodaj
#
###
# stara kolejka
# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
# 4 (max: 5, min: 0)
#
# nowa kolejka:
# [ 8 (max: 8, min: 0); ] - size nie jest dwa, dodaj

###
# stara kolejka
# 1 (max: 1, min: 1)
# 0 (max: 1, min: 0)
# 2 (max: 2, min: 0)
# 5 (max: 5, min: 0)
#
#
# nowa kolejka:
# [ 8 (max: 8, min: 0), 5 (max: 5, min: 0)] - size nie jest dwa, dodaj

# ([1, 0, 2, 5, 4, 8], 2)

# stara [1]
# nowa []

# stara [0]
# nowa [1]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1

# in [2]
# out [0]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1

# stara [5]
# nowa [2]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1

# a dla okna o nieparzystej ilości elementów np 3?

# ([1, 0, 2, 5, 4, 8], 3)

# pół 1 i reszta do drugiej

# stara [1]
# nowa []

# stara []
# nowa [1]

# stara [0]
# nowa [1]

# stara [2]
# nowa [0, 1]

# maxS: 2, minS: 2
# maxN:1, minN: 0
# różnica 2

# usuwam z nowej, nie mam trzech, trzeba dobrać
# stara [2]
# nowa [0]

# usuwam z nowej, nie mam trzech, trzeba dobrać
# stara [2]
# nowa [0]

# maxS: 2, minS: 2
# maxN:1, minN: 0
# różnica 2

# stara []
# nowa [1]

# stara [0]
# nowa [1]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1

# in [2]
# out [0]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1

# stara [5]
# nowa [2]
# maxstare = 0, minstarej = 0
# maxnowej =1, minnowej = 1
