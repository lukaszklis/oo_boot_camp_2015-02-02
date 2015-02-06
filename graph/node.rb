# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'link'
require_relative 'path'

# Understands its neighbors
class Node

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
    self._path_to(destination, no_visited_nodes, Path::LEAST_HOP_COUNT) != Path::NONE
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
    return Path::NONE if visited_nodes.include?(self)
    @links.map do |link|
      link._path_to(destination, visited_nodes + [self], cost_strategy)
    end.min(&cost_strategy) || Path::NONE
  end

  def paths_to(destination, visited_nodes = [])
    return [Path.new] if self == destination
    return [] if visited_nodes.include?(self)
    @links.inject([]) do |results, link|
      results + link._paths_to(destination, visited_nodes + [self])
    end
  end

  def to_s
    @label
  end

  private

    def safe_path_to(destination, cost_strategy)
      self._path_to(destination, no_visited_nodes, cost_strategy).tap do |result|
        raise "No path from #{self} to #{destination}" if result == Path::NONE
      end
    end

    def no_visited_nodes
      []
    end

end

# path_to: Classes 1; Methods 10; Executable 17
# NoPath:  Classes 1; Methods 10; Executable 17
