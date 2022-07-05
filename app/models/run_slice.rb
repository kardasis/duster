class RunSlice < ApplicationRecord
  # Represents a portion of a run: start and end times as well as distance implied
  # by start and end ticks
  belongs_to :run_summary
end
