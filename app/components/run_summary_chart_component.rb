# The chart showing all the runs
class RunSummaryChartComponent < ViewComponent::Base
  def data
    Date.beginning_of_week = :sunday

    summaries = RunSummary.all.order(start_time: :asc)
    monday = summary_week summaries[0]

    mondays = []
    monday_hash = {}

    while monday < DateTime.now
      monday_hash[monday] = mondays.length
      mondays.push(monday)
      monday += 7.days
    end

    datasets = initial_data mondays.length

    summaries.each do |s|
      i = monday_hash[summary_week(s)]
      datasets[s.start_time.wday][:data][i] += s.total_distance.to_f
    end

    labels = mondays.map { |d| d.strftime('%b %e') }
    {
      datasets:,
      labels:
    }
  end

  def initial_data(number_of_weeks)
    [
      { label: 'Sunday', data: Array.new(number_of_weeks, 0), backgroundColor: 'grey' },
      { label: 'Monday', data: Array.new(number_of_weeks, 0), backgroundColor: 'purple' },
      { label: 'Tuesday', data: Array.new(number_of_weeks, 0), backgroundColor: 'blue' },
      { label: 'Wednesday', data: Array.new(number_of_weeks, 0), backgroundColor: 'green' },
      { label: 'Thursday', data: Array.new(number_of_weeks, 0), backgroundColor: 'yellow' },
      { label: 'Friday', data: Array.new(number_of_weeks, 0), backgroundColor: 'orange' },
      { label: 'Saturday', data: Array.new(number_of_weeks, 0), backgroundColor: 'red' }
    ]
  end

  def summary_week(summary)
    summary.start_time.beginning_of_week
  end
end
