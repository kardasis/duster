require 'rails_helper'

describe RunSummary, type: :model do
  describe '.create' do
    it 'should calculate basic fields' do
      run = create :run, :with_small_data
      run.generate_summary
      expect(run.summary.run).to eq run
      expect(run.summary.start_time).to eq run.created_at.round
      expect(run.summary.total_time).to eq 444.0 / 1000
      expect(run.summary.distance_records).to be_empty
    end

    it 'should works on a larger run' do
      run = create :run, :with_data
      run.generate_summary
      expect(run.summary.distance_records.length).to be 3
    end
  end

  describe '#summary_calories' do
    it 'calculates' do
      run = create :run, :with_data
      run_summary = run.generate_summary
      expect(run_summary.summary_calories).to be_within(1).of run_summary.calories
    end
  end
end
