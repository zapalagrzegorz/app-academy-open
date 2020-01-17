# frozen_string_literal: true

# With that done, we're going to implement a queue again, but with a twist: rather than use an Array, we will implement it using our MyStack class under the hood because pushing and popping from MyStack takes O(1) time. Done properly, we will still have a queue but with the advantages of dequeuing in O(1) time.

# Before you start to code this, sit down and talk to your partner about how you might implement this. You should not modify your MyStack class, but use the interface it provides to implement a queue.

# When you're ready, implement this StackQueue class with size, empty?, enqueue, and dequeue methods.
class StackQueue
  def initialize
    # @store = [MyStack.new(current), myStack.new([])]

    # przy dwóch wartościach, tablica jest zbędna
    # istota tablicy to kolekcja elementów uporządkowych
    # bez niej, jest czytelniej
    @in_stack = MyStack.new
    @out_stack = MyStack.new
  end

  def size
    # ?
    # @store.first.size
    @in_stack.size + @out_stack.size
  end

  def empty?
    # u mnie to in_stack.empty?
    # @store.first.empty?
    @in_stack.empty? && @out_stack.empty?
  end

  # stań do kolejki
  # na marginesie - przy tym konkretnym rozwiazaniu,lepiej chyba inicjalizować tę strukturę istniejącą tablicą, a nie kolejkować pojedyńczo
  def enqueue
    # @store.last.push(@store.first.pop) unless empty?
    # O(1)
    @in_stack.push(val)
  end

  # opuść kolejkę
  def dequeque
    # upewnij się, że kolejka nie jest pusta, i ew. ją zaincjalizuj otrzymanymi danymi
    queueify if @out_stack.empty?
    # If we haven't already reversed the stack, this runs in O(n). However, we
    # only have to do this once for every n dequeue operations, so it amortizes
    # to O(1)
    @out_stack.pop
  end

  private

  def queueify
    # How do you turn a stack into a queue? Flip it upside down.
    @out_stack.push(@in_stack.pop) until @in_stack.empty?
  end
end

# [] enq, deq
# niezgody ze wskazówkami
# pierwszy wariant sam stos
# enquequeing - ok
# jak miałbym dequequeing robić? To będzie pobierało z końca, a nie początku,
# to nie kolejka

# drugi wariant tablica stosów - [MyStack.new, MyStack.new]
#  enquequeing - ok push
# dequeque - zwykły unshift
# jeżli nie unshift to mogę to ręcznie zrobić
#  iteracja po elementach tablicy i reasignment wartości
# a co to wtedy za różnica ze zwykłą tablicą/kolejką

# trzeci stos kolejek
# jeżeli podstawą jest stos, to jak zbudować zachowanie kolejki - dequequeing

# czwarty - wiele stosów
# to jeszcze kolejka stosów
# problem unshift - jeżeli stos ma zawierać jeden element, to ten sam problem z tablicą stosów. Jeżli nie unshift to mogę to ręcznie zrobić, czyli
#  iteracja po elementach tablicy i reasignment wartości
# Co to wtedy za różnica ze zwykłą tablicą/kolejką

# enqueque (new_value)
# {
# store.last =  new_value
# }
# [ MyStack.new, MyStack.new, new/pop].
# queque [pop first, second, ..., new]

# Hint: You will want to use more than one instance of MyStack.

# Hint 2: What if you always pushed onto one stack, and always popped from the other? How will these two stacks interact?

# [1, 0, 2, 5, 4, 8], 2

# przed
# stack1 - []
# stack2 - [1, 0, 2, 5, 4, 8]

# 0 iteracja
# stack1 - [8, 4]
# stack2 - [1, 0, 2, 5]

# 1 iteracja
# stack1 - [8, 4, 5]
# stack2 - [1, 0, 2]

# 2 iteracja
# stack1 - [8, 4, 5, 2]
# stack2 - [1, 0]

# 3 iteracja
# stack1 - [8, 4, 5, 2, 0]
# stack2 - [1]

# 3 iteracja
# stack1 - [8, 4, 5, 2, 0, 1]
# stack2 - []

# Hint 3: Think about how a slinky walks down stairs. As the slinky descends down a stair step, the top of a slinky becomes the bottom of the slinky...
# [1, 0, 2, 5, 4, 8], 2

# przed
# stack1 - []
# stack2 - (bottom) [1, 0, 2, 5, 4, 8] (top)

# 0 iteracja
# stack1 - [8]
# stack2 - [0, 2, 5,4, 8]

# 1 iteracja
# stack1 - [8, 4]
# stack2 - [0, 2, 5]

# 2 iteracja
# stack1 - [8,4, 5]
# stack2 - [0,2]

# 3 iteracja
# stack1 - [8,4,5,2]
# stack2 - [0]

# 3 iteracja
# stack1 - [8,4,5,2,0]
# stack2 - []
