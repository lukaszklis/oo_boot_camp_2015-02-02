# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a specific metric
class Unit
  attr_reader :base_unit_count

  def initialize(relative_unit = nil, amount = 1)
    @base_unit_count = (relative_unit ? relative_unit.base_unit_count : 1) * amount.to_f
  end

  def converted_amount(other, other_amount)
    other_amount * other.base_unit_count / self.base_unit_count
  end

  TEASPOONS = new
  TABLESPOONS = new(TEASPOONS, 3)
  OUNCES = new(TABLESPOONS, 2)
  CUPS = new(OUNCES, 8)
  PINTS = new(CUPS, 2)
  QUARTS = new(PINTS, 2)
  GALLONS = new(QUARTS, 4)

end
