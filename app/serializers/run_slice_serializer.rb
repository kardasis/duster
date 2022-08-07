class RunSliceSerializer
  include JSONAPI::Serializer
  set_key_transform :camel_lower

  attributes :nominal_distance, :start_index, :end_index, :start_time, :end_time
end
