class Cirrus::Lock
  attr_accessor :id, :key

  LOCK_IDS_KEY            = 'cirrus_locks'
  LOCKED_IDS_KEY          = 'cirrus_locked_ids'
  LOCKS_TO_LOCKED_IDS_KEY = 'cirrus_locks_to_locked_ids'

  def initialize *ids
    @id  = SecureRandom.hex(8)
    @key = Cirrus::Key.generate(ids)
  end

  def set
    Cirrus.store.multi do
      Cirrus.store.sadd LOCKED_IDS_KEY, @key
      Cirrus.store.sadd LOCK_IDS_KEY, @id
      Cirrus.store.hset LOCKS_TO_LOCKED_IDS_KEY, @id, @key
    end.all? { |result| result == true }
  end

  def release
    ids_to_release = Cirrus.store.hget LOCKS_TO_LOCKED_IDS_KEY, @id
    Cirrus.store.hdel LOCKS_TO_LOCKED_IDS_KEY, @key

    Cirrus.store.multi do
      Array(ids_to_release).each { |id| Cirrus.store.srem LOCKED_IDS_KEY, id }
      Cirrus.store.srem LOCK_IDS_KEY, @id
    end.all? { |result| result == true }
  end

  def locked?
    Cirrus.store.sismember(LOCKED_IDS_KEY, @key)
  end
end