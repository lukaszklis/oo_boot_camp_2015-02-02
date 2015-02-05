# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands its neighbors
class Node

  UNREACHABLE = Float::INFINITY

  attr_reader :label
  protected :label

  def initialize(label)
    @label = label
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

  def hop_count(destination)
    result = self._hop_count(destination, no_visited_nodes)
    raise "No path from #{self} to #{destination}" if result == UNREACHABLE
    result
  end

  def to_s
    @label
  end

  protected

    def _hop_count(destination, visited_nodes)
      return 0 if self == destination
      return UNREACHABLE if visited_nodes.include? self
      @neighbors.reduce(UNREACHABLE) do |champion, n|
        challenger = n._hop_count(destination, visited_nodes << self) + 1
        challenger < champion ? challenger : champion
      end
    end

  private

    def no_visited_nodes
      []
    end

end
