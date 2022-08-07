# The chart showing all the runs
class RunSummaryChartComponent < ViewComponent::Base
  def bar_data
    Date.beginning_of_week = :sunday

    @summaries = RunSummary.includes(:distance_records).all.order(start_time: :asc)

    collect_sundays
    datasets = calculate_datasets @sundays.length

    labels = @sundays.map { |d| d.strftime('%b %e') }
    { datasets:, labels: }
  end

  def collect_sundays
    @sundays = []
    @sunday_hash = {}

    @sunday = summary_week @summaries[0]
    while @sunday < DateTime.now
      @sunday_hash[@sunday] = @sundays.length
      @sundays.push(@sunday)
      @sunday += 7.days
    end
  end

  def indexed_summaries
    res = {}
    @summaries.each do |summary|
      i = @sunday_hash[summary_week(summary)]
      res["#{summary.start_time.wday},#{i}"] = RunSummarySerializer.new(summary, include: [:distance_records])
    end
    res
  end

  def calculate_datasets(_number_of_weeks)
    datasets = initial_data

    @summaries.each do |s|
      i = @sunday_hash[summary_week(s)]
      datasets[s.start_time.wday][:data][i] += s.total_distance.to_f
    end
    datasets
  end

  def initial_data
    number_of_weeks = @sundays.length
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
