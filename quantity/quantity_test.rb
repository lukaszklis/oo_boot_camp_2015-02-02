# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'unit'

# Confirms Quantity works correctly
class QuantityTest < Minitest::Test

  def test_equality_of_like_units
    assert_equal 3.ounces, 3.ounces
    refute_equal 3.ounces, 4.ounces
    refute_equal 3.ounces, Object.new
    refute_equal 3.ounces, nil
  end

  def test_equality_of_unlike_units
    assert_equal 24.ounces, 1.5.pints
    assert_equal 1.5.pints, 24.ounces
    refute_equal 2.ounces, 2.cups
  end

end
