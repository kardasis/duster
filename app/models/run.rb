# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :summary, class_name: 'RunSummary', dependent: :destroy
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
    interval_data.second_data
  end

  def generate_summary
    build_summary
    summary.tickstamps = tickstamps
    summary.calculate_summary
    if summary.save
      RunDataStore.remove id
    end
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
    @tickstamps = normalize(tickstamps)
  end

  private

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
