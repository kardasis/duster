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
    end
  end
end
