# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run
  has_many :distance_records, class_name: 'RunSlice', dependent: :destroy

  validates :total_distance, presence: true
  validates :total_time, presence: true

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

  def self.create_with_params(params)
    summary = new params
    summary.calculate_calories
    summary.save
    summary
  end

  def self.create_with_tickstamps(tickstamps, run)
    total_distance = tickstamps.length / TICKS_PER_MILE
    total_time = tickstamps.last / 1000
    start_time = calc_start_time run.start_time
    res = create(total_distance:, total_time:, start_time:, calories: run.total_calories, run:)
    res.calculate_distance_records(tickstamps)
    res
  end

  def calculate_calories
    self.calories ||= summary_calories
  end

  def summary_calories(incline: 1.0, weight: 192.0)
    total_time * (weight / 1_584_000.0) * ((average_speed * (322.0 + (14.5 * incline))) + 210.0)
  end

  def self.calc_start_time(run_start_time)
    Time.at(run_start_time).utc
  end

  def average_speed
    total_distance / (total_time / SECONDS_PER_HOUR)
  end
end
