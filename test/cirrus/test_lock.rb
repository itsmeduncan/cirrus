require 'minitest_helper'

class TestLock < MiniTest::Unit::TestCase

  def setup
    @redis = Redis.new
    @redis.flushall
  end

  def test_lock_generates_an_id
    Cirrus::Lock.new(@redis, :foo).id.wont_be_nil
  end

  def test_lock_sets_up_redis
    Cirrus::Lock.new(@redis, :foo).redis.wont_be_nil
  end

  def test_lock_sets_up_values
    assert_equal([:foo, :bar], Cirrus::Lock.new(@redis, :foo, :bar).values)
  end

  def test_set_returns_true
    lock = Cirrus::Lock.new(@redis, :foo, :bar)

    assert_equal(true, lock.set)
  end

  def test_set_returns_false_if_it_is_already_set
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    lock.set

    assert_equal(false, lock.set)
  end

  def test_release_frees_the_lock
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    lock.set
    assert_equal(true, lock.release)
  end

  def test_release_returns_false
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    assert_equal(false, lock.release)
  end

  def test_release_frees_the_lock
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    lock.set

    lock.release
    assert_equal(false, lock.locked?)
  end

  def test_locked_returns_true
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    lock.set

    assert_equal(true, lock.locked?)
  end

  def test_locked_returns_false
    lock = Cirrus::Lock.new(@redis, :foo, :bar)
    assert_equal(false, lock.locked?)
  end

end