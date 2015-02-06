# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'composite_quantity'

# Confirms CompositeQuantity works correctly
class CompositeQuantityTest < Minitest::Test

  A = CompositeQuantity.new(3.ounces, 2.cups, 4.feet)
  B = CompositeQuantity.new(4.tablespoons, 1.5.quarts, 0.5.yards)

  def test_arithmetic
    assert_equal CompositeQuantity.new(5.ounces, 4.pints, 5.5.feet), A + B
    assert_equal CompositeQuantity.new(1.ounces, -1.quarts, 2.5.feet), A - B
  end

  def test_mismatched_composites
    assert_raises(ArgumentError) { A + CompositeQuantity.new(4.ounces) }
  end

  def test_differen_size_composites
    refute_equal A, CompositeQuantity.new(4.ounces)
  end

end
