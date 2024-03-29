# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :summary, class_name: 'RunSummary', dependent: :destroy
  has_one :run_data, dependent: :destroy
  has_one :live_run, dependent: :destroy

  validates :start_time, presence: true

  self.implicit_order_column = 'created_at'

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
    interval_data&.second_data
  end

  def generate_summary
    self.summary = RunSummary.create_with_tickstamps tickstamps, self
    RunDataStore.remove id
    summary
  end

  def add_datapoints(data)
    live_run || create_live_run

    live_run.update_with(data)
    RunDataStore.add(id, data)
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

  def tickstamps=(tickstamps)
    @tickstamps = normalize(tickstamps.map(&:to_i))
  end

  def total_calories
    interval_data&.total_calories
  end

  private

  def interval_data
    @interval_data ||= IntervalData.new self
  end

  def key_bucket
    if run_data&.raw_data_uri
      key, bucket = ColdDataStore.key_bucket(run_data&.raw_data_uri)
    else
      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = id
    end
    [key, bucket]
  end

  def calculate_tickstamps
    res = RunDataStore.get id
    if res
      normalize res
    else
      key, bucket = key_bucket
      res = ColdDataStore.fetch_s3_data(bucket, key)
      if res
        normalize res[:ticks].map(&:to_i)
      end
    end
  end
end
