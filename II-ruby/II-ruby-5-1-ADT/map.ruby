class Array
  def second
    self[1] if self[1]
  end

  def second=(value)
    self[1] = value if self[1]

    value
  end
end

class Map
  def initialize
    @map = []
    # [k1, v1], [k2, v2], [k3, v2], ...
  end

  def set(key, value)
    # always (O(n))
    @map.each do |entry|
      if entry.first == key
        entry.second = value
        return self
      end
    end

    # find index, which makes the same
    #     pair_index = underlying_array.index { |pair| pair[0] == key }

    @map.push([key, value])
  end

  def get(key)
    @map.each do |entry|
      if entry.first == key
        # entry.second = value
        return entry.second
      end
    end

    nil
  end

  def delete(key)
    map_without_item = map.reject do |entry|
      entry.first == key
    end

    @map = map_without_item
  end

  # Returns duplicate
  def show
    map.map do |pair|
      pair.map(&:clone)
    end
  end

  def inspect
    { map: @map }.inspect
  end

  private

  attr_reader :map
end
