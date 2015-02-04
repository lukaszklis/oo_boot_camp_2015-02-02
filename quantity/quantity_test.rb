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
    assert_equal 9.feet, 3.yards
    assert_equal 0.celcius, 32.fahrenheit
    assert_equal 32.fahrenheit, 0.celcius
    assert_equal -40.celcius, -40.fahrenheit
    assert_equal -40.fahrenheit, -40.celcius
    assert_equal 10.celcius, 50.fahrenheit
    assert_equal 50.fahrenheit, 10.celcius
    assert_equal 100.celcius, 212.fahrenheit
    assert_equal 212.fahrenheit, 100.celcius
    refute_equal 0.celcius, 0.fahrenheit
    refute_equal 100.fahrenheit, 100.celcius
  end

  def test_inequality_of_different_unit_types
    refute_equal 1.inches, 1.tablespoons
    refute_equal 4.ounces, 2.feet
  end

  def test_hash
    assert_equal 3.ounces.hash, 3.ounces.hash
    assert_equal 24.ounces.hash, 1.5.pints.hash
    assert_equal 9.feet.hash, 3.yards.hash
  end

  def test_comparison
    assert 3.ounces > 2.ounces
    assert 2.ounces <= 3.ounces
    assert 1.1.pints < 24.ounces
  end

  def test_arithmetic
    assert_equal 14.ounces, 2.cups - 4.tablespoons
    assert_equal -14.ounces, 4.tablespoons - 2.cups
    assert_equal -14.ounces, -(14.ounces)
  end

  def test_mixed_type_arithmetic
    assert_raises(RuntimeError) { 2.feet + 3.ounces }
  end

end
