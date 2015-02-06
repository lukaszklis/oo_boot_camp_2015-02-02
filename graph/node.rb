# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'link'

# Understands its neighbors
class Node

  UNREACHABLE = Float::INFINITY

  attr_reader :label
  protected :label

  def initialize(label)
    @label = label
    @links = []
  end

  def >(neighbor_cost_pair)
    @links << Link.new(*neighbor_cost_pair)
    neighbor_cost_pair.first
  end

  def can_reach(destination)
    self._cost(destination, no_visited_nodes) != UNREACHABLE
  end

  def hop_count(destination)
    safe_cost(destination, Link::LEAST_HOP_COUNT)
  end

  def cost(destination)
    safe_cost(destination, Link::LEAST_COST)
  end

  def _cost(destination, visited_nodes, cost_strategy = Link::LEAST_COST)
    return 0 if self == destination
    return UNREACHABLE if visited_nodes.include?(self)
    @links.map do |link|
      link._cost(destination, visited_nodes.clone << self, cost_strategy)
    end.min || UNREACHABLE
  end

  def to_s
    @label
  end

  private

    def safe_cost(destination, cost_strategy)
      self._cost(destination, no_visited_nodes, cost_strategy).tap do |result|
        raise "No path from #{self} to #{destination}" if result == UNREACHABLE
      end
    end

    def no_visited_nodes
      []
    end

end
