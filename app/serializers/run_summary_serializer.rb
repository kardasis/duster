# frozen_string_literal: true

class RunSummarySerializer < ActiveModel::Serializer
  attributes :run_id, :total_time, :total_distance, :start_time, :id, :distance_records
end
