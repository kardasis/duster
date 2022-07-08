require 'rails_helper'

describe RunSummary, type: :model do
  describe 'create' do
    it 'should calculate basic fields' do
      run = create :run, :with_small_data
      summary = RunSummary.from_run run
      run.summary = summary
      expect(run.summary.run).to eq run
      expect(run.summary.start_time).to eq run.created_at
      expect(run.summary.total_time).to eq 444.0 / 1000
      expect(run.summary.distance_records).to be_empty
    end

    it 'works on a larger run' do
      run = create :run, :with_data
      summary = RunSummary.from_run run
      run.summary = summary
      expect(summary.distance_records.length).to be 2
    end
  end
end
