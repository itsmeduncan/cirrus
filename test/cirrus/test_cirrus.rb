require 'minitest_helper'

class TestCirrus < MiniTest::Unit::TestCase

  def setup
    @redis = Redis.new
    @redis.flushall
  end

  def test_cirrus_runs_the_block
    assert_equal(:foo, Cirrus.lock(@redis, 1,2) { :foo })
  end

  def test_cirrus_raises_because_it_is_locked
    lambda {
      Cirrus.lock(@redis, 1, 2) { Cirrus.lock(@redis, 1, 2) { :foo } }
    }.must_raise Cirrus::UnlockableException
  end

  def test_it_releases_if_there_is_an_error
    lambda {
      Cirrus.lock(@redis, 1, 2) { raise ArgumentError }
    }.must_raise ArgumentError

    assert_equal(:foo, Cirrus.lock(@redis, 1, 2) { :foo })
  end

end