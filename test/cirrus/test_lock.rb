require 'minitest_helper'

class TestLock < MiniTest::Unit::TestCase

  def setup
    Redis.new.flushall
  end

  def test_initializer_generates_a_key
    lock = Cirrus::Lock.new('foo', 'bar')
    assert_equal lock.key, 'foo_bar'
  end

  def test_initializer_generates_an_id
    lock = Cirrus::Lock.new('foo', 'bar')
    lock.id.wont_be_nil
  end

  def test_sets_lock
    lock = Cirrus::Lock.new('foo', 'bar')
    assert_equal lock.set, true
  end

  def test_release_lock
    lock = Cirrus::Lock.new('foo', 'bar')
    assert_equal lock.set, true
    assert_equal lock.release, true
  end

  def test_locked_is_true
    lock = Cirrus::Lock.new('foo', 'bar')
    lock.set

    assert_equal lock.locked?, true
  end

  def test_locked_is_false
    lock = Cirrus::Lock.new('foo', 'bar')
    lock.set
    assert_equal lock.locked?, true

    lock.release
    assert_equal lock.locked?, false
  end

end