require 'rails_helper'

describe DuplicateRunSummary do
  describe '#call' do
    it 'should return the best time' do
      old_summary = create :run_summary, :with_distance_records

      new_summary = DuplicateRunSummary.call(old_summary.id)
      expect(new_summary.total_distance).to eq old_summary.total_distance
      expect(new_summary.calories).to eq old_summary.calories
      expect(new_summary.id).not_to eq old_summary.id
      expect(new_summary.distance_records.length).to eq old_summary.distance_records.length
    end
  end
end
