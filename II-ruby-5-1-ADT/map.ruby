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
    @map.each do |entry|
      if entry.first == key
        entry.second = value
        return self
      end
    end

    @map.push([key, value])
  end

  def get(key)
  end

  def delete(key)
  end

  def show
  end
end
