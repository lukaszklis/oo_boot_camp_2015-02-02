# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'quantity'

# Confirms Quantity works correctly
class QuantityTest < Minitest::Test

  def test_equality_of_like_units
    assert_equal(Quantity.new(3, Unit::OUNCES), Quantity.new(3, Unit::OUNCES))
    refute_equal(Quantity.new(3, Unit::OUNCES), Quantity.new(4, Unit::OUNCES))
    refute_equal(Quantity.new(3, Unit::OUNCES), Object.new)
    refute_equal(Quantity.new(3, Unit::OUNCES), nil)
  end

  def test_equality_of_unlike_units
    assert_equal(Quantity.new(24, Unit::OUNCES), Quantity.new(1.5, Unit::PINTS))
    assert_equal(Quantity.new(1.5, Unit::PINTS), Quantity.new(24, Unit::OUNCES))
    refute_equal(Quantity.new(2, Unit::OUNCES), Quantity.new(2, Unit::CUPS))
  end

end
