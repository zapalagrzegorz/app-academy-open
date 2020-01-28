# frozen_string_literal: true

require 'byebug'
class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
    # removes self?
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new('HEAD', 'HEAD')
    @tail = Node.new('TAIL', 'TAIL')
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail
  end

  def get(key)
    node = find(key)
    return nil unless node

    node.val
  end

  def include?(key)
    find(key) ? true : false
  end

  # Append a new node to the end of - the list.
  def append(key, val)
    node = Node.new(key, val)

    last.next = node
    node.prev = last

    node.next = @tail
    @tail.prev = node
  end

  def update(key, val)
    node = find(key)
    return nil unless node

    node.val = val
  end

  def remove(key)
    node = find(key)
    return nil unless node

    node.remove
  end

  def each
    return if empty?

    node = first
    loop do
      yield node
      break if node == last

      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private

  def find(key)
    return if empty?

    node = first
    loop do
      return node if node.key == key
      break if node == last

      node = node.next
    end
  end
end
