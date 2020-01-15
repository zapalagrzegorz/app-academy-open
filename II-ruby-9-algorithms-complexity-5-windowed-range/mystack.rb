# frozen_string_literal: true

class MyStack
  def initialize(store = [])
    @store = store
  end

  def peek
    @store.last
  end

  def pop
    @store.pop
  end

  def push(item)
    @store.push(item)
  end

  def empty?
    @store.empty?
  end
end

# Implement peek, size, empty?, pop and push methods on your Stack.
