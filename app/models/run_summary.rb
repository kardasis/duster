# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run
  has_many :distance_records, class_name: 'RunSlice', dependent: :destroy

  attr_accessor :tickstamps

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

  def calculate_summary
    self.total_distance = @tickstamps.length / TICKS_PER_MILE
    self.total_time = @tickstamps.last / 1000
    self.start_time = Time.at(run.start_time).utc
    calculate_distance_records(@tickstamps)

    IntervalData.new run
    save
    self
  end
end
