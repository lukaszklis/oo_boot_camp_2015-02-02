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

  def can_reach(destination)
    self._hop_count(destination, no_visited_nodes) != UNREACHABLE
  end

  def hop_count(destination)
    self._hop_count(destination, no_visited_nodes).tap do |result|
      raise "No path from #{self} to #{destination}" if result == UNREACHABLE
    end
  end

  def to_s
    @label
  end

  protected

    def _hop_count(destination, visited_nodes)
      return 0 if self == destination
      return UNREACHABLE if visited_nodes.include?(self)
      @neighbors.map do |n|
        n._hop_count(destination, visited_nodes.clone << self) + 1
      end.min || UNREACHABLE
    end

  private

    def no_visited_nodes
      []
    end

end
