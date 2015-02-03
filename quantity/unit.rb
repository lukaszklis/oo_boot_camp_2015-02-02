# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

# Understands a specific metric
class Unit
  attr_reader :base_unit_count

  def initialize(plural_name, relative_unit = nil, amount = 1)
    @base_unit_count = (relative_unit ? relative_unit.base_unit_count : 1) * amount.to_f
    create_numeric_method(plural_name)
  end

  def converted_amount(other, other_amount)
    other_amount * other.base_unit_count / self.base_unit_count
  end

  private

    def create_numeric_method(plural_name)
      unit = self
      Numeric.class_eval do
        define_method plural_name.to_s do
          Quantity.new(self, unit)
        end
      end
    end

  TEASPOONS = new('teaspoons')
  TABLESPOONS = new('tablespoons', TEASPOONS, 3)
  OUNCES = new('ounces', TABLESPOONS, 2)
  CUPS = new('cups', OUNCES, 8)
  PINTS = new('pints', CUPS, 2)
  QUARTS = new('quarts', PINTS, 2)
  GALLONS = new('gallons', QUARTS, 4)

end
