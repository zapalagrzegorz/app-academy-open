# frozen_string_literal: true

# Implement peek, size, empty?, enqueue, and dequeue

class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def empty?
    @store.empty?
  end

  def enqueue(item)
    @store << item
  end

  # However, removing items from MyQueue takes O(n) time. 
  # As the first element of the array is shifted off, 
  # the remaining elements will be reassigned in new position in memory. 
  # Also, it still leaves us with the problem of expensive min and max operations. To resolve this, we'll have to make clever use of another data structure, the stack.
  def dequeue
    @store.shift
  end
end
