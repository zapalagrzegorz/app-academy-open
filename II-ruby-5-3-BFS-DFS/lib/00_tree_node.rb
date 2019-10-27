require "byebug"

class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    debugger
    return if parent.nil?

    @parent = parent
    parent.children << self
  end
end
