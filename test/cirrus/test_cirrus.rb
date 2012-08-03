require 'minitest_helper'

class TestCirrus < MiniTest::Unit::TestCase

  def setup
    @redis = Redis.new
    @redis.flushall
  end

  def test_cirrus_runs_the_block
    assert_equal(:foo, Cirrus.lock(@redis, 1,2) { :foo })
  end

end