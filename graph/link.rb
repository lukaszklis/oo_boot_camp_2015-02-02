# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a connection to a particular Node
class Link

  LEAST_HOP_COUNT = lambda { |_| 1 }
  LEAST_COST = lambda { |cost| cost }

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _path_to(destination, visited_nodes, cost_strategy)
    @target._path_to(destination, visited_nodes, cost_strategy).tap do |result|
      result.pre_pend(self, @cost) unless result.nil?
    end
  end

  def to_s
    ">>#{cost}>>"
  end

end
