# Home for the data that a run uses while it's active.
class LiveRun < ApplicationRecord
  belongs_to :run

  def update_with(data)
    self.first_tickstamp ||= data.first.to_i
    self.last_tickstamp = data.last.to_i
    self.tick_count += data.length

    RunChannel.broadcast_to run, client_update_data
    save
  end

  private

  def client_update_data
    {
      total_time:,
      total_distance:
    }
  end

  def total_time
    t = ActiveSupport::Duration.build((last_tickstamp - first_tickstamp) / 1000.0).to_i
    format('%<h>02d:%<m>02d:%<s>02d', { h: t / 3600, m: t / 60 % 60, s: t % 60 })
  end

  def total_distance
    (tick_count / TICKS_PER_MILE).round(4).to_s
  end
end
