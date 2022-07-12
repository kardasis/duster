# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run
  has_many :distance_records, class_name: 'RunSlice', dependent: :destroy

  def self.from_s3_bucket(bucket, key)
    start_time = key[/.*-(\d*)\.json/, 1]
    if start_time && RunSummary.exists?({ start_time: Time.at(start_time.to_i).utc })
      return nil
    end

    data = ColdDataStore.fetch_s3_data bucket, key

    run = Run.create_with_start_time data['startTime']

    summary = new({ run:, raw_data_uri: ColdDataStore.s3_uri(bucket, key) })
    summary.calculate_summary(normalize(data['ticks'].map(&:to_i))).save
    summary
  end

  def self.from_run(run)
    tickstamps = normalize(RunDataStore.get(run.id))
    raw_data_uri = ColdDataStore.store_raw_json(tickstamps, run)

    summary = new({ run:, raw_data_uri: })
    summary.calculate_summary(tickstamps).save
    summary
  end

  def calculate_distance_records(tickstamps)
    btfd = BestTimeForDistance.new(tickstamps)
    RECORD_DISTANCES.each do |name, miles|
      best = btfd.calculate(miles:)
      if best
        params = best.merge({ nominal_distance: name }).except(:time)
        run_slice = RunSlice.create(params)
        distance_records << run_slice
      end
    end
  end

  def self.normalize(raw_ticks)
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

  def calculate_summary(tickstamps)
    self.total_distance = tickstamps.length / TICKS_PER_MILE
    self.total_time = tickstamps.last / 1000
    self.start_time = Time.at(run.start_time).utc
    calculate_distance_records(tickstamps)
    self
  end
end
