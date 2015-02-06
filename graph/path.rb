# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a way that one Node can reach another specific Node
class Path

  LEAST_HOP_COUNT = lambda { |left, right| left.hop_count <=> right.hop_count }
  LEAST_COST = lambda { |left, right| left.cost <=> right.cost }

  def initialize
    @links = []
    @path_cost = 0
  end

  def pre_pend(link, link_cost)
    @links.unshift(link)
    @path_cost += link_cost
  end

  def hop_count
    @links.size
  end

  def cost
    @path_cost
  end

  class NoPath
    def pre_pend(*); end # Deliberately empty
    def hop_count; Float::INFINITY; end
    def cost; Float::INFINITY; end
  end

  NONE = NoPath.new

end



# path_to: Class 3, Methods 6, Executable 8
# path_to: Class 4, Methods 9, Executable 11
