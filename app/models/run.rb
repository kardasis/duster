# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :summary, class_name: 'RunSummary', dependent: :destroy
  validates :start_time, presence: true

  def self.create_with_start_time(start_time)
    run = Run.new
    run.start_time = Time.at(start_time.to_i).utc.round
    run.save
    run
  end

  def tickstamps
    @tickstamps ||= calculate_tickstamps
  end

  def second_data
    interval_data.second_data
  end

  def generate_summary
    build_summary
    summary.tickstamps = tickstamps
    summary.calculate_summary
    summary.save
  end

  def add_datapoints(data)
    self.first_tickstamp ||= data.first.to_i
    save
    @last = data.last.to_i

    RunDataStore.add(id, data)
    RunChannel.broadcast_to self, live_data
  end

  def live_data
    {
      total_time: (last_tick - first_tick) / 1000.0,
      total_distance: RunDataStore.get_count(id) / TICKS_PER_MILE
    }
  end

  def normalize(raw_ticks)
    res = []
    prev = raw_ticks[0]
    raw_ticks.drop(1).each do |t|
      if t - prev > DEBOUNCE_TIME
        res.push(t - raw_ticks[0])
        prev = t
      end
    end
    res
  end

  private

  def first_tick
    first_tickstamp
  end

  def last_tick
    @last
  end

  def interval_data
    if @interval_data
      return @interval_data
    end

    @interval_data = IntervalData.new self
  end

  def calculate_tickstamps
    res = RunDataStore.get id
    if !res
      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = id
      res = ColdDataStore.fetch_s3_data(bucket, key)
      if res
        res = res[:ticks]
      end
    end
    normalize res
  end
end
