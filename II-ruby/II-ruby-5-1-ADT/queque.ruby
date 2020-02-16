class Queque
  def initialize
    @queque = []
  end

  def enqueue(el)
    @queque << el
  end

  def dequeue
    @queque.shift
  end

  def peek
    queque.first
  end
end
