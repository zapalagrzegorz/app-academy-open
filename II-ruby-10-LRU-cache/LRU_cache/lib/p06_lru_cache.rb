# frozen_string_literal: true

require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map.get(key)
    if node
      # there's key
      # update node in list
      update_node!(node)
    # return value

    # there isnt key
    else
      # compute value
      # call proc
      value = @prc.call(key)
      # list.append(key, value)
      node = @store.append(key, value)
      # hash.add(key) pointing to new node
      # add value
      @map.set(key, node)
      # has exceeded its max size?
      # eject! first item in list
      eject! if @map.count > @max

      value
    end
    # delete - first in linkedList and then from hash
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    @store.remove(node.key)
    node_updated = @store.append(node.key, node.val)
    @map.set(node.key, node_updated)
  end

  def eject!
    node = @store.first.remove
    @map.delete(node.key)
  end
end
