class RunDataStore
  # This class wraps the commands needed to add and fetch data from
  # the Redis data store.

  def self.add(run_id, tickstamps)
    pairs = tickstamps.map do |t|
      [t.to_i, t]
    end
    Redis.new.zadd run_id, pairs
  end

  def self.get(run_id)
    Redis.new.zrangebyscore(run_id, -Float::INFINITY, +Float::INFINITY, withscores: true)
         .map(&:second)
  end
end
