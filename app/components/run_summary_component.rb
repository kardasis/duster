# Small card describing the run
class RunSummaryComponent < ViewComponent::Base
  def initialize(run_summary:)
    @run_summary = run_summary
  end

  def total_distance
    sprintf '%0.2f', @run_summary.total_distance
  end

  def total_time
    format_duration @run_summary.total_time
  end

  def speed
    s = (@run_summary.total_distance / @run_summary.total_time) * SECONDS_PER_HOUR
    sprintf '%0.3f', s
  end

  def distance_records
    @run_summary.distance_records
  end

  def format_duration(duration)
    m = duration / 60 % 60
    s = duration % 60
    if duration < SECONDS_PER_HOUR
      sprintf('%<m>d:%<s>02d', { m:, s: })
    else
      h = duration / 3600
      sprintf('%<h>d:%<m>02d:%<s>02d', { h:, m:, s: })
    end
  end
end
