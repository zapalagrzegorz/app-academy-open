# frozen_string_literal: true

require 'set'

def my_uniq(arr)
  raise ArgumentError unless arr.is_a?(Array)

  Set.new(arr).to_a
end
