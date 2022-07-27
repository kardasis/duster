# This class wraps the commands needed to add and fetch data from
# the Redis data store.
class RunDataStore
  @client = Redis.new

  def self.client
    @client ||= Redis.new
  end

  def self.add(run_id, tickstamps)
    pairs = tickstamps.map do |t|
      [t.to_i, t]
    end
    client.zadd run_id, pairs
  end

  def self.get(run_id)
    client.zrangebyscore(run_id, -Float::INFINITY, +Float::INFINITY, withscores: true)
          .map(&:second).presence || nil
  end

  def self.get_count(run_id)
    client.zcount(run_id, -Float::INFINITY, +Float::INFINITY)
  end

  def self.take(run_id)
    res = get run_id
    remove run_id
    res
  end

  def self.remove(run_id)
    client.del(run_id)
  end
end
