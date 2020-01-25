# frozen_string_literal: true

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { [] }
    @count = 0
  end

  def insert(key)
    resize! if @count + 1 == num_buckets
    unless include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless include?(key)

    self[key].delete(key)
    @count -= 1
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    # map existing items into new array twice big
    resized_store = Array.new(num_buckets * 2) { [] }
    @store.each do |sub_arr|
      sub_arr.each { |element| resized_store[element.hash % resized_store.size] << element }
    end
    @store = resized_store
  end
end
