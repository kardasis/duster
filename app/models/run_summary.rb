# A class in charge of extracting data from the data store and performing
# calculations to summarize the run
class RunSummary < ApplicationRecord
  belongs_to :run

  before_validation :calculate

  def self.ticks_per_mile
    5280 * (6 / 3.12)
  end

  private

  def calculate
    tickstamps = normalize(RunDataStore.get(run.id))
    self.total_distance = tickstamps.length / self.class.ticks_per_mile
    self.total_time = tickstamps.last / 1000
    self.start_time = run.created_at
  end

  def normalize(raw_ticks)
    res = []
    prev = raw_ticks[0]
    raw_ticks.drop(1).each do |t|
      if t - prev > debounce_time
        res.push(t - raw_ticks[0])
        prev = t
      end
    end
    res
  end

  def debounce_time
    20
  end

  # Some constants for future use
  # MILLIS_PER_HOUR : 60 * 60 * 1000,
  # SPEED_SMOOTHING : 0.5,
end
