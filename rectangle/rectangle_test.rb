# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'rectangle'

# Confirms Rectangle works correctly
class RectangleTest < Minitest::Test

  def test_area
    assert_equal 12, Rectangle.new(3, 4).area
    assert_equal 12, Rectangle.new(2, 6).area
  end

  def test_perimeter
    assert_equal 14, Rectangle.new(3, 4).perimeter
    assert_equal 16, Rectangle.new(2, 6).perimeter
  end

  def test_square
    assert_equal 9, Rectangle.square(3).area
    assert_equal 12, Rectangle.square(3).perimeter
  end

end
