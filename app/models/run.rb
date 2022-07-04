# frozen_string_literal: true

# The primary model for dealing with a run.
class Run < ApplicationRecord
  has_one :run_summary, dependent: :destroy
end
