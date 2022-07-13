# Generates the interval data for a run.
# This is the speed, distance, etc for each second.
class IntervalData
  attr_reader :second_data

  def initialize(debounced_data)
    @debounced_data = debounced_data
    calculate
  end

  def calculate
    @second_data = calculate_interval_data
  end

  def length
    @second_data.length
  end

  private

  def calculate_interval_data(incline: 1, weight: 192)
    second_chunks.map do |item|
      window_begin, window_end, second = item.values_at(:window_begin, :window_end, :second)
      ticks_per_millis = (window_end - window_begin) / (@debounced_data[window_end] - @debounced_data[window_begin])
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

  def second_chunks
    last_tick = @debounced_data.last
    i = 0
    (1..last_tick / 1000).map do |second|
      window_begin = i
      while @debounced_data[i] < 1000 * second
        i += 1
      end
      { second:, window_begin:, window_end: i }
    end
  end
end
