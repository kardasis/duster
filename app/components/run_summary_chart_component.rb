# The chart showing all the runs
class RunSummaryChartComponent < ViewComponent::Base
  def data
    res = RunSummary.includes(:distance_records).all.group_by do |rs|
      rs.start_time.beginning_of_day
    end

      res.transform_values do |summaries|
      summaries.map do |s|
        {
          distance_records: s.distance_records,
          start_time: s.start_time,
          day: s.start_time.beginning_of_day,
          total_distance: s.total_distance,
          total_time: s.total_time
        }
      end
    end
  end
end
