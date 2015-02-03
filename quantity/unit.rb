# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require_relative 'quantity'

# Understands a specific metric
class Unit
  attr_reader :type, :base_unit_count, :offset
  protected :type, :base_unit_count, :offset

  def initialize(type, plural_name, relative_unit, amount, offset = 0)
    @type = type
    @base_unit_count = (relative_unit ? relative_unit.base_unit_count : 1) * amount.to_f
    @offset = offset
    create_numeric_method(plural_name)
  end

  def self.volume(plural_name, relative_unit = nil, amount = 1)
    new(:volume, plural_name, relative_unit, amount)
  end

  def self.distance(plural_name, relative_unit = nil, amount = 1)
    new(:distance, plural_name, relative_unit, amount)
  end

  def self.temperature(plural_name, relative_unit = nil, amount = 1, offset = 0)
    new(:temperature, plural_name, relative_unit, amount, offset)
  end

  def converted_amount(other, other_amount)
    raise "Incompatible unit types" unless self.compatible? other
    (other_amount - other.offset) * other.base_unit_count / self.base_unit_count + self.offset
  end

  def amount_hash(amount)
    (base_unit_count * amount).hash
  end

  def compatible?(other)
    self.type == other.type
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

  teaspoons = volume('teaspoons')
  tablespoons = volume('tablespoons', teaspoons, 3)
  ounces = volume('ounces', tablespoons, 2)
  cups = volume('cups', ounces, 8)
  pints = volume('pints', cups, 2)
  quarts = volume('quarts', pints, 2)
  gallons = volume('gallons', quarts, 4)

  inches = distance('inches')
  feet = distance('feet', inches, 12)
  yards = distance('yards', feet, 3)
  miles = distance('miles', yards, 1760)

  celcius = temperature('celcius')
  fahrenheit = temperature('fahrenheit', celcius, 5/9.0, 32)

end
