require 'rails_helper'

describe RunSummary, type: :model do
  describe 'create' do
    it 'should calculate basic fields' do
      run = create :run, :with_small_data
      summary = run.create_run_summary
      expect(summary.run).to eq run
      expect(summary.start_time).to eq run.created_at
      expect(summary.total_time).to eq 444.0 / 1000
      expect(summary.distance_records).to be_empty
    end

    it 'works on a larger run' do
      run = create :run, :with_data
      summary = run.create_run_summary
      expect(summary.distance_records.length).to be 2
    end
  end
end
