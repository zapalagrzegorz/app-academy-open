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
    @head
  end

  def last
    @tail
  end

  def empty?
    debugger
    first.next == last
  end

  def get(key); end

  def include?(key)
    self[key]
  end

  # Append a new node to the end of - the list.
  # head <--> tail

  # head -->  <--tail

  # head <--> node
  def append(key, val)
    node = Node.new(key, val)
    # H <-- node(k, v) --> T
    # debugger
    node.prev = last.prev
    node.next = last

    # debugger
    # H <--> node -- > T
    last.prev.next = node

    # H <--> node <-- > T
    last.prev = node
  end

  def update(key, val); end

  def remove(key); end

  def each; end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
