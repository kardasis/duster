# Responsible for storing the raw device data and the processed interval data from a run
class RunData < ApplicationRecord
  belongs_to :run
end
