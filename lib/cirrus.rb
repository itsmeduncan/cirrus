$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))

require "securerandom"
require "redis"

require "cirrus/version"
require "cirrus/lock"

module Cirrus
  class UnlockableException < Exception; end

  def self.lock(redis, *ids)
    lock = Cirrus::Lock.new(redis, ids)

    raise UnlockableException.new("Could not set lock: #{ids.inspect}") unless lock.set

    yield

  ensure
    lock.release

  end

end