# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a connection to a particular Node
class Link

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _hop_count(destination, visited_nodes)
    @target._hop_count(destination, visited_nodes) + 1
  end

  def to_s
    ">>#{cost}>>"
  end

end
