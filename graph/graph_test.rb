# Copyright 2015 by Fred George. May be copied with this notice, but not used in classroom training.

require 'minitest/autorun'
require_relative 'node'

# Confirms graph operations work correctly
class GraphTest < Minitest::Test

  ('A'..'G').each { |label| const_set(label.to_sym, Node.new(label)) }
  B > [A, 6]
  B > [C, 5] > [D, 2] > [E, 3] > [B, 4] > [F, 7]
  C > [D, 1]
  C > [E, 8]

  def test_can_reach
    assert B.can_reach A
    assert B.can_reach C
    assert C.can_reach F
    refute G.can_reach B
    refute A.can_reach B
    refute B.can_reach G
  end

  def test_hop_count
    assert_equal 0, A.hop_count(A)
    assert_equal 1, B.hop_count(A)
    assert_equal 1, B.hop_count(C)
    assert_equal 3, C.hop_count(F)
    assert_raises(RuntimeError) { A.hop_count B }
    assert_raises(RuntimeError) { B.hop_count G }
  end

  def test_cost
    assert_equal 0, A.cost(A)
    assert_equal 6, B.cost(A)
    assert_equal 5, B.cost(C)
    assert_equal 15, C.cost(F)
    assert_raises(RuntimeError) { A.cost B }
    assert_raises(RuntimeError) { B.cost G }
  end

  def test_path_to
    assert_path_traits A, A, 0, 0
    assert_path_traits B, A, 1, 6
    assert_path_traits B, C, 1, 5
    assert_path_traits C, F, 4, 15
    assert_raises(RuntimeError) { A.path_to B }
    assert_raises(RuntimeError) { B.path_to G }
  end

  def test_paths_to
    assert_equal 1, A.paths_to(A).size
    assert_equal 1, B.paths_to(A).size
    assert_equal 1, B.paths_to(C).size
    assert_equal 3, C.paths_to(F).size
    assert_equal 0, A.paths_to(B).size
    assert_equal 0, B.paths_to(G).size
  end

  private

    def assert_path_traits(source, destination,
          expected_hop_count, expected_cost)
      result = source.path_to(destination)
      assert_equal expected_hop_count, result.hop_count
      assert_equal expected_cost, result.cost
    end

end

# TOTALS:
# path_to:  Class 5; Methods 18; Executable 28
# NoPath:   Class 6; Methods 21; Executable 31
# paths_to: Class 5; Methods 18; Executable 27
