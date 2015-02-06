# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a connection to a particular Node
class Link

  def initialize(target, cost)
    @target, @cost = target, cost
  end

  def _paths_to(destination, visited_nodes)
    @target.paths_to(destination, visited_nodes).each do |path|
      path.pre_pend(self, @cost)
    end
  end

end

# path_to:  Class 1; Methods 2; Executable 3
# NoPath:   Class 1; Methods 2; Executable 3
# paths_to: Class 1; Methods 2; Executable 3
