# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :summary, class_name: 'RunSummary', dependent: :destroy

  attr_writer :start_time

  def self.create_with_start_time(start_time)
    run = Run.new
    run.start_time = start_time
    run.save
    run
  end

  def start_time
    @start_time || created_at
  end
end
