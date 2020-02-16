# frozen_string_literal: true

require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count + 1 == num_buckets
    #  resize! if self.count >= num_buckets

    unless bucket(key).update(key, val)
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    removal = bucket(key).remove(key)
    @count -= 1 if removal

    removal
  end

  def each
    @store.each do |list|
      list.each { |node| yield [node.key, node.val] }
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias [] get
  alias []= set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # map existing items into new array twice big
    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |linkedList|
      linkedList.each { |node| new_store[node.key.hash % new_store.size].append(node.key, node.val) }
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
