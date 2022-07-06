# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :run_summary, dependent: :destroy

  def raw_data_json
    data_hash = {
      startTime: start_time.to_i,
      ticks: RunDataStore.get(id).map(&:to_i)
    }
    data_hash.to_json
  end

  def start_time
    created_at
  end
end
