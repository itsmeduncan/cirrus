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

end