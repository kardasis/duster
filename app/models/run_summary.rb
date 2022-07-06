# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run
  has_many :distance_records, class_name: 'RunSlice', dependent: :destroy

  before_validation :calculate

  private

  def calculate
    @tickstamps = normalize(RunDataStore.get(run.id))
    self.total_distance = @tickstamps.length / TICKS_PER_MILE
    self.total_time = @tickstamps.last / 1000
    self.start_time = run.created_at
    calculate_distance_records
  end

  def calculate_distance_records
    btfd = BestTimeForDistance.new(@tickstamps)
    RECORD_DISTANCES.each do |name, miles|
      best = btfd.calculate(miles:)
      if best
        params = best.merge({ nominal_distance: name }).except(:time)
        run_slice = RunSlice.create(params)
        distance_records << run_slice
      end
    end
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
end
