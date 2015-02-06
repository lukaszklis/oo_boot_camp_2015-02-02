# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a way that one Node can reach another specific Node
class Path

  LEAST_HOP_COUNT = lambda { |left, right| left.hop_count <=> right.hop_count }
  LEAST_COST = lambda { |left, right| left.cost <=> right.cost }

  def initialize
    @links = []
  end

  def pre_pend(link)
    @links.unshift(link)
  end

  def hop_count
    @links.size
  end

  def cost
    Link.total(@links)
  end

end
