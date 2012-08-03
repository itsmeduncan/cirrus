$LOAD_PATH.unshift(File.join(File.dirname(__FILE__)))

require "securerandom"
require "redis"

require "cirrus/version"
require "cirrus/key"
require "cirrus/lock"

module Cirrus

  def self.store
    @@store
  end

  def self.store=(redis)
    @@store = redis
  end

end