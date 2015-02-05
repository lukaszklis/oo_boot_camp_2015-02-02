# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands its neighbors
class Node

  def initialize
    @neighbors = []
  end

  def >(neighbor)
    @neighbors << neighbor
    neighbor
  end

  def can_reach(destination, visited_nodes = [])
    return true if self == destination
    return false if visited_nodes.include? self
    @neighbors.any? do |n|
      n.can_reach(destination, visited_nodes << self)
    end
  end

end
