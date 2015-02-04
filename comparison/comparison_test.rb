# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'comparison'
require_relative '../probability/chance'
require_relative '../quantity/unit'

# Confirms Comparison works correctly
class ComparisonTest < Minitest::Test

  def test_maximum_among_probabilities
    assert_equal 0.6.chance, Comparison.max(
      0.1.chance,
      0.6.chance,
      0.5.chance,
      0.4.chance
    )
  end

  def test_maximum_among_volumes
    assert_equal 6.ounces, Comparison.max(
      10.tablespoons,
      0.5.cups,
      6.ounces,
      19.teaspoons
    )
  end

end
