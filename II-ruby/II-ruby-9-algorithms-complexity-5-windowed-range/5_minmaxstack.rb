# frozen_string_literal: true

# Before we move on, let's take a step back to our MyStack class. We'll modify it so that we always know the maximum value in the stack. We could write a max method that calls @store.max. However, this requires us to iterate over every item in the @store array, which gives us a time complexity of O(n). This isn't good enough for us; we want to be able to return the max in constant time (O(1)).

# If we can't iterate over @store, how else could we modify the stack to get this functionality?

# Once you have max implemented, it should be easy to add a min method.

# na bieżąco dodając element sprawdzać czy jest najwiekszy?

# Hint: We could store some metadata with the value of each element. In other words, we can be storing more information than just the value with new element to the store. Think about how to do this and what information to store.

# Implement peek, size, empty?, max, min, pop, push methods on your MinMaxStack.

# frozen_string_literal: true

require_relative '3_mystack'

class MinMaxStack
  # attr_reader :max, :min
  def initialize
    @store = MyStack.new
  end

  def peek
    @store.peek[:value]
  end

  def pop
    # is it necessary to pop pointing to :value?
    # nie jest niezbędne
    # @store.pop[:value] unless empty?
    @store.pop unless empty?
  end

  # def push(item)
  #   @store.push(item)
  #   @max = item if item > @max
  #   @min = item if item < @min
  # end

  def push(val)
    # By using a little extra memory, we can get the max simply by peeking,
    # which is O(1)
    # informację max-min trzymać w każdym elemencie magazynu
    # nie jest to zbędna duplikacja?.
    # Inaczej w ten sposób mogę śledzić na bieżąco zmiany. Zmienna będzie porównywała wartość minimimalną i maksymalną ze sobą, ale nie będzie zmieniać wcześniejszych np.
    # dodam na stos 2 i 3 efekt każda ma indywidualną wartość dla min i max:
    # [{:max=>2, :min=>2, :value=>2}, {:max=>3, :min=>2, :value=>3}]

    @store.push(
      max: new_max(val),
      min: new_min(val),
      value: val
    )
  end

  def empty?
    @store.empty?
  end

  # zakładając,że nie ma duplikatów i nie śledzę usuwania elementu, ale
  # zapisuję historię największego, to wystarczy śledzić wartości przy dodaniu
  # def max; end

  def max
    @store.peek[:max] unless empty?
  end

  def min
    @store.peek[:min] unless empty?
  end

  private

  def new_max(val)
    empty? ? val : [max, val].max
  end

  def new_min(val)
    empty? ? val : [min, val].min
  end
end

# Implement peek, size, empty?, pop and push methods on your Stack.
