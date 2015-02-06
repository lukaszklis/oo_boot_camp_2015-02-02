# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'link'
require_relative 'path'

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

  def path_to(destination)
    safe_path_to(destination)
  end

  def _path_to(destination, visited_nodes)
    return Path.new if self == destination
    return nil if visited_nodes.include?(self)
    @links.map do |link|
      link._path_to(destination, visited_nodes.clone << self)
    end.compact.min &Path::LEAST_COST || UNREACHABLE
  end

  def to_s
    @label
  end

  private

    def safe_path_to(destination)
      self._path_to(destination, no_visited_nodes).tap do |result|
        raise "No path from #{self} to #{destination}" if result.nil?
      end
    end

    def safe_cost(destination, cost_strategy)
      self._cost(destination, no_visited_nodes, cost_strategy).tap do |result|
        raise "No path from #{self} to #{destination}" if result == UNREACHABLE
      end
    end

    def no_visited_nodes
      []
    end

end
