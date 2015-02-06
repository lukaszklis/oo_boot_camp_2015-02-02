# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'unit'

# Understands an aggregated (yet segregated) measurement
class CompositeQuantity

  attr_reader :quantities
  protected :quantities

  def initialize(*ratio_quantities)
    @quantities = ratio_quantities.flatten
  end

  def ==(other)
    return false unless other.is_a? CompositeQuantity
    return true if self.equal? other
    self.quantities == other.quantities
  end

  def +(other)
    raise ArgumentError.new('Composites have different sizes') unless self.quantities.size == other.quantities.size
    CompositeQuantity.new(
      self.quantities.zip(other.quantities).map { |left, right| left + right }
    )
  end

  def -@
    CompositeQuantity.new(@quantities.map { |q| -q })
  end

  def -(other)
    self + -other
  end

  def zero_value
    CompositeQuantity.new(quantities.map(&:zero_value))
  end

  def to_s
    "[#{@quantities.map(&:to_s).join}]"
  end

end
