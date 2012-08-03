require 'minitest_helper'

class TestKey < MiniTest::Unit::TestCase

  def test_generate_returns_a_key
    key = Cirrus::Key.generate('foo')
    assert_equal 'foo', key
  end

  def test_generate_returns_a_key_from_multiple_inputs
    key = Cirrus::Key.generate('foo', 'bar', 'widget')
    assert_equal 'foo_bar_widget', key
  end

  def test_generate_downcases_the_input
    key = Cirrus::Key.generate('FOO', 'BAR')
    assert_equal 'foo_bar', key
  end

  def test_generate_removes_nonword_charachters
    key = Cirrus::Key.generate('foo', 'b_r')
    assert_equal 'foo_br', key
  end

  def test_generate_removes_nil_values
    key = Cirrus::Key.generate('foo', '')
    assert_equal 'foo', key
  end

  def test_generate_allows_numbers
    key = Cirrus::Key.generate(1, 2, 3, 4, 5, 6)
    assert_equal '1_2_3_4_5_6', key
  end

end