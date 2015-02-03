# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'quantity'

# Understands a specific metric
class Unit
  attr_reader :base_unit_count
  protected :base_unit_count

  def initialize(plural_name, relative_unit = nil, amount = 1)
    @base_unit_count = (relative_unit ? relative_unit.base_unit_count : 1) * amount.to_f
    create_numeric_method(plural_name)
  end

  def converted_amount(other, other_amount)
    other_amount * other.base_unit_count / self.base_unit_count
  end

  def amount_hash(amount)
    (base_unit_count * amount).hash
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

  teaspoons = new('teaspoons')
  tablespoons = new('tablespoons', teaspoons, 3)
  ounces = new('ounces', tablespoons, 2)
  cups = new('cups', ounces, 8)
  pints = new('pints', cups, 2)
  quarts = new('quarts', pints, 2)
  gallons = new('gallons', quarts, 4)

end
