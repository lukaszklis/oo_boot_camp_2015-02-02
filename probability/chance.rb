# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands liklihood of a specific event occurring
class Chance

  attr_reader :value
  protected :value

  CERTAIN_VALUE = 1.0
  EPSILON = 0.000001

  def initialize(liklihood_as_fraction)
    @value = liklihood_as_fraction
  end

  def ==(other)
    return true if self.equal? other
    return false unless other.is_a? Chance
    (self.value - other.value).abs < EPSILON
  end

  def ~@
    Chance.new(CERTAIN_VALUE - self.value)
  end

  def &(other)
    Chance.new(self.value * other.value)
  end

  def |(other)
    ~(~self & ~other)
  end

  def better_than?(other)
    self.value > other.value
  end

end

class Numeric

  def chance
    Chance.new(self)
  end

end
