require 'rails_helper'

describe RunSummary, type: :model do
  describe 'create' do
    it 'should calculate basic fields' do
      run = create :run
      RunDataStore.add run.id, [123, 345, 567]
      summary = run.create_run_summary
      expect(summary.run).to eq run
      expect(summary.start_time).to eq run.created_at
      expect(summary.total_time).to eq 444.0 / 1000
      expect(summary.distance_records).to be_empty
    end

    it 'works on a larger run' do
      run = create :run
      data = (0...10_000).map do |i|
        i * 50 - i * i / 10_000_000
      end
      RunDataStore.add run.id, data
      summary = run.create_run_summary
      expect(summary.distance_records.length).to be 2
    end
  end
end
