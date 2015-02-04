# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'ratio_quantity'

# Understands a specific metric
class Unit
  attr_reader :type, :base_unit_count, :offset
  protected :type, :base_unit_count, :offset

  def initialize(plural_name, relative_unit, amount = 1, offset = 0)
    @type = relative_unit.type
    @base_unit_count = relative_unit.base_unit_count * amount.to_f
    @offset = offset
    create_numeric_method(plural_name, @type.quantity_class)
  end

  def converted_amount(other, other_amount)
    raise "Incompatible unit types" unless self.compatible? other
    (other_amount - other.offset) * other.base_unit_count / self.base_unit_count + self.offset
  end

  def amount_hash(amount)
    (base_unit_count * amount).hash + type.hash * 23
  end

  def compatible?(other)
    self.type == other.type
  end

  private

    def create_numeric_method(plural_name, quantity_class)
      unit = self
      Numeric.class_eval do
        define_method plural_name.to_s do
          quantity_class.new(self, unit)
        end
      end
    end

  class BaseUnit
    attr_reader :type, :quantity_class
    def initialize(quantity_class); @quantity_class = quantity_class; end
    def base_unit_count; 1; end
    def type; self; end
  end

  teaspoons = Unit.new('teaspoons', BaseUnit.new(RatioQuantity))
  tablespoons = Unit.new('tablespoons', teaspoons, 3)
  ounces = Unit.new('ounces', tablespoons, 2)
  cups = Unit.new('cups', ounces, 8)
  pints = Unit.new('pints', cups, 2)
  quarts = Unit.new('quarts', pints, 2)
  gallons = Unit.new('gallons', quarts, 4)

  inches = Unit.new('inches', BaseUnit.new(RatioQuantity))
  feet = Unit.new('feet', inches, 12)
  yards = Unit.new('yards', feet, 3)
  miles = Unit.new('miles', yards, 1760)

  celsius = Unit.new('celsius', BaseUnit.new(IntervalQuantity))
  fahrenheit = Unit.new('fahrenheit', celsius, 5/9.0, 32)

end
