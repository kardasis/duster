# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run
  has_many :distance_records, class_name: 'RunSlice', dependent: :destroy

  def calculate_distance_records
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

  def tickstamps
    run.tickstamps
  end

  def calculate_summary
    calculate_distance_records
    self.total_distance = tickstamps.length / TICKS_PER_MILE
    self.total_time = tickstamps.last / 1000

    self.start_time = calc_start_time
    self.calories = run.total_calories

    save
    self
  end

  def calc_start_time
    Time.at(run.start_time).utc
  end

  def average_speed
    total_distance / (total_time / SECONDS_PER_HOUR)
  end
end
