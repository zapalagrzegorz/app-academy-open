# frozen_string_literal: true

# class MaxWindowedRange
#   def initialize
#     @store = MinMaxStackQueue
#   end
# end

def max_windowed_range(_array, _window_size)
  queue = MinMaxStackQueue.new
  best_range = nil

  array.each_with_index do |el, _i|
    queue.enqueue(el)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      current_range = queue.max - queue.min
      best_range = current_range if !best_range || current_range > best_range
    end
  end

  #   p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5
  # 0, 2, 5

  # queue.dequeue if queue.size > window_size
  # queue(new) = [8,4,5,2] - przestawiamy na nowy stos
  # queue(old) = [2,5,4,8] , i usuwamy ostatni (8)
  # queue(old) = [2,5,4] , i usuwamy ostatni (8) -> [2,5,4]
  # moge obliczyć okno
  #
  # zabrakło rozpisania na papierze ( w głowie nie widać! aż tak dobrze)
  # i dobrego zrozumienia struktury danych minmaxStackQueue, gdzie były
  # wystarczające wskazówki
end
