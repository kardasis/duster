require 'rails_helper'

describe RunSummaryChartComponent, type: :component do
  describe '#bar_data' do
    it 'return correct data' do
      create :run_summary,
             start_time: DateTime.new(2022, 7, 19, 1, 2, 3), # tuesday
             total_distance: 4.5
      create :run_summary,
             start_time: DateTime.new(2022, 7, 24, 1, 2, 3), # sunday
             total_distance: 2.6
      create :run_summary,
             start_time: DateTime.new(2022, 7, 30, 1, 2, 3), # saturday
             total_distance: 4.4

      allow(DateTime).to receive(:now).and_return(DateTime.new(2022, 8, 10, 1, 2, 3))

      labels = ['Jul 17', 'Jul 24', 'Jul 31', 'Aug  7'] # blank padded
      expected = {
        labels:,
        datasets:
      }

      expect(RunSummaryChartComponent.new.bar_data).to eq expected
    end
  end
end

def datasets
  [
    { label: 'Sunday', data: [0, 2.6, 0, 0], backgroundColor: 'grey' },
    { label: 'Monday', data: [0, 0, 0, 0], backgroundColor: 'purple' },
    { label: 'Tuesday', data: [4.5, 0, 0, 0], backgroundColor: 'blue' },
    { label: 'Wednesday', data: [0, 0, 0, 0], backgroundColor: 'green' },
    { label: 'Thursday', data: [0, 0, 0, 0], backgroundColor: 'yellow' },
    { label: 'Friday', data: [0, 0, 0, 0], backgroundColor: 'orange' },
    { label: 'Saturday', data: [0, 4.4, 0, 0], backgroundColor: 'red' }
  ]
end
