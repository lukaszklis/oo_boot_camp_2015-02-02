# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'interval_quantity'

# Understands a specific measurement
class RatioQuantity < IntervalQuantity

  def +(other)
    RatioQuantity.new(self.amount + converted_amount(other), self.unit)
  end

  def -@
    RatioQuantity.new(-amount, unit)
  end

  def -(other)
    self + (-other)
  end

  def zero_value
    RatioQuantity.new(0, unit)
  end

  private

    def converted_amount(other)
      @unit.converted_amount(other.unit, other.amount)
    end

end
