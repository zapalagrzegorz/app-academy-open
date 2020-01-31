# frozen_string_literal: true

class LRUCache
  def initialize(size)
    @cache = []
    @size = size
  end

  def count
    # returns number of elements currently in cache
    @cache.compact.size
  end

  def add(element)

    if @cache.include?(element)
      @cache.delete(element)
      @cache << element
    elsif @cache.count < @size
      @cache << element
    else
      @cache.shift
      @cache << element
    end
  end

  def show
    # shows the items in the @cache, with the LRU item first
    p @cache
  end

  private

  # helper methods go here!
  def reappend_el(index)
    element = @cache.slice!(index)
    @cache << element
  end

  def add_new(element)
    @cache.shift
    @cache << element
  end
end
