class RunSummarySerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower

  has_many :distance_records, serializer: RunSliceSerializer, record_type: :run_slice

  attributes :run_id, :total_time, :total_distance, :start_time, :id, :average_speed, :calories
end
