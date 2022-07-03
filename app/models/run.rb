# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  before_validation :set_run_id
  attr_accessor :run_id

  validates :run_id, presence: true

  def set_run_id
    self.run_id = SecureRandom.uuid
  end
end
