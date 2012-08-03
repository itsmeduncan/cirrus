require 'minitest_helper'

class TestCirrus < MiniTest::Unit::TestCase

  def test_setting_of_the_store
    redis         = Redis.new
    Cirrus.store  = redis

    assert_equal Cirrus.store, redis
  end

end