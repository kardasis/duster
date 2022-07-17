# Generates the interval data for a run.
# This is the speed, distance, etc for each second.
class IntervalData
  attr_reader :second_data

  def initialize(run)
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    key = "#{run.id}-interval"

    @tickstamps = run.tickstamps
    @second_data = ColdDataStore.fetch_s3_data(bucket, key)
    @second_data ||= calculate_interval_data
  end

  def length
    @second_data.length
  end

  private

  def calculate_interval_data(incline: 1, weight: 192)
    second_chunks.map do |item|
      window_begin, window_end, second = item.values_at(:window_begin, :window_end, :second)
      ticks_per_millis = (window_end - window_begin) / (@tickstamps[window_end] - @tickstamps[window_begin])
      immediate_speed = ticks_per_millis ? ticks_per_millis * MILLIS_PER_HOUR / TICKS_PER_MILE : 0

      { calories: calories_calc(weight, immediate_speed, incline),
        immediate_speed:,
        time: second,
        distance: window_end / TICKS_PER_MILE }
    end
  end

  def calories_calc(weight, immediate_speed, incline)
    (1.0 / 60.0) * (weight / 26_400.0) * ((immediate_speed * (322.0 + (14.5 * incline))) + 210.0)
  end

  def second_chunks(ms_per_chunk = 1000)
    last_tick = @tickstamps.last
    i = 0
    (1..last_tick / ms_per_chunk).map do |second|
      window_begin = i
      while @tickstamps[i] < ms_per_chunk * second
        i += 1
      end
      { second:, window_begin:, window_end: i }
    end
  end
end
