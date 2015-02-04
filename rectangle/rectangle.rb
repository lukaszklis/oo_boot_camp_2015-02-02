# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a four-sided polygon with sides at right angles
class Rectangle

  def initialize(height, width)
    @height, @width = height, width
  end

  def self.square(side)
    self.new(side, side)
  end

  def area
    @height * @width
  end

  def perimeter
    2 * (@height + @width)
  end

  def square?
    @height == @width
  end

end
