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
    self._path_to(destination, no_visited_nodes, Path::LEAST_HOP_COUNT) != nil
  end

  def hop_count(destination)
    safe_path_to(destination, Path::LEAST_HOP_COUNT).hop_count
  end

  def cost(destination)
    self.path_to(destination).cost
  end

  def path_to(destination)
    safe_path_to(destination, Path::LEAST_COST)
  end

  def _path_to(destination, visited_nodes, cost_strategy)
    return Path.new if self == destination
    return nil if visited_nodes.include?(self)
    @links.map do |link|
      link._path_to(destination, visited_nodes + [self], cost_strategy)
    end.compact.min &cost_strategy
  end

  def to_s
    @label
  end

  private

    def safe_path_to(destination, cost_strategy)
      self._path_to(destination, no_visited_nodes, cost_strategy).tap do |result|
        raise "No path from #{self} to #{destination}" if result.nil?
      end
    end

    def no_visited_nodes
      []
    end

end
