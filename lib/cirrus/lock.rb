class Cirrus::Lock
  attr_accessor :id, :redis, :values

  LOCKED = "cirrus:locked"
  LOCKS  = "cirrus:locks"

  def initialize(redis, *values)
    @redis  = redis

    @id     = SecureRandom.hex(8)
    @values = values
  end

  def set
    redis.multi do
      redis.sadd(LOCKS, id)
      redis.sadd(LOCKED, values)
      redis.sadd(pointer, values)
    end.all? { |result| result.is_a?(Integer) ? result > 0 : result == true }
  end

  def release
    releasable_ids = redis.smembers(pointer)

    redis.multi do
      redis.srem(pointer, releasable_ids)
      redis.srem(LOCKED, values)
      redis.srem(LOCKS, id)
    end.all? { |result| result.is_a?(Integer) ? result > 0 : result == true }
  end

  def locked?
    redis.multi do
      values.each do |value|
        redis.sismember(LOCKED, value)
      end
    end.any? { |result| result == true }
  end

  private

  def pointer
    "cirrus:#{id}:pointers"
  end

end