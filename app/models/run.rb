# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :summary, class_name: 'RunSummary', dependent: :destroy
  validates :start_time, presence: true

  def self.create_with_start_time(start_time)
    run = Run.new
    run.start_time = Time.at(start_time.to_i).utc.round
    run.save
    run
  end
end
