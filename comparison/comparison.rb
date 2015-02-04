# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands the "largest" among a collection of elements
class Comparison

  def self.max(*elements)
    elements = elements.flatten
    elements.flatten.reduce(elements[0]) do |champion, challenger|
      challenger.better_than?(champion) ? challenger : champion
    end
  end

end
