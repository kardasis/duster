# Home for the data that a run uses while it's active.
class LiveRun < ApplicationRecord
  belongs_to :run

  def update_with(data)
    self.start_tickstamp ||= data.first.to_i

    @tick_data = normalize(data)

    self.tick_count += @tick_data.length

    RunChannel.broadcast_to run, client_update_data

    self.last_tick = @tick_data.last
    save
  end

  private

  def normalize(data)
    data = data.map(&:to_i)
    if last_tick
      data.prepend last_tick
    end
    data.filter.with_index { |d, i| d - data[i - 1] > DEBOUNCE_TIME }
        .map { |d| d - start_tickstamp }
  end

  def client_update_data
    { stats: {
        'total-time': total_time_formatted,
        'total-distance': total_distance_formatted,
        speed: speed_formatted,
        'average-speed': average_speed_formatted,
        pace: pace_formatted,
        'average-pace': average_pace_formatted
      },
      intervalTicks: [[total_time, new_speed]] }
  end

  def speed_formatted
    format('%0.3f', new_speed)
  end

  def pace_formatted
    seconds_per_mile = SECONDS_PER_HOUR / new_speed
    format_duration seconds_per_mile
  end

  def new_speed
    return @new_speed if @new_speed.present?

    @new_speed = if speed
                   (immediate_speed * (1 - SPEED_SMOOTHING)) + (SPEED_SMOOTHING * speed)
                 else
                   immediate_speed
                 end
  end

  def immediate_speed
    ticks_per_millis = if last_tick.nil?
                         (@tick_data.length.to_f - 1) / @tick_data.last
                       else
                         @tick_data.length.to_f / (@tick_data.last - last_tick)
                       end
    ticks_per_millis * MILLIS_PER_HOUR / TICKS_PER_MILE
  end

  def total_time_formatted
    format_duration total_time
  end

  def total_distance_formatted
    format('%0.4f', total_distance)
  end

  def average_speed
    SECONDS_PER_HOUR * total_distance / total_time
  end

  def total_distance
    tick_count / TICKS_PER_MILE
  end

  def total_time
    @tick_data.last / 1000.0
  end

  def average_speed_formatted
    format '%0.3f', average_speed
  end

  def average_pace_formatted
    seconds_per_mile = SECONDS_PER_HOUR / average_speed
    format_duration seconds_per_mile
  end

  def format_duration(duration)
    m = duration / 60 % 60
    s = duration % 60
    if duration < SECONDS_PER_HOUR
      format('%<m>d:%<s>02d', { m:, s: })
    else
      h = duration / 3600
      format('%<h>d:%<m>02d:%<s>02d', { h:, m:, s: })
    end
  end
end
