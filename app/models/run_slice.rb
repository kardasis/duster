# Represents a portion of a run: start and end times as well as distance implied
# by start and end ticks
class RunSlice < ApplicationRecord
  belongs_to :run_summary
end
