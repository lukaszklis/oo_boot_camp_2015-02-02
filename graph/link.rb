# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a connection to a particular Node
class Link

  LEAST_HOP_COUNT = lambda { |cost| 1 }
  LEAST_COST = lambda { |cost| cost }

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _cost(destination, visited_nodes, cost_strategy)
    @target._cost(destination, visited_nodes, cost_strategy) +
        cost_strategy.call(@cost)
  end

  def to_s
    ">>#{cost}>>"
  end

end
