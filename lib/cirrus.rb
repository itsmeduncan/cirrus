$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))

require "securerandom"
require "redis"

require "cirrus/version"
require "cirrus/lock"

module Cirrus

  def self.lock(redis, *ids)
    lock = Cirrus::Lock.new(redis, ids)

    lock.set

    yield.tap { |_| lock.release }
  end

end