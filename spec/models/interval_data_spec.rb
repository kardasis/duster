# frozen_string_literal: true

require 'rails_helper'

describe IntervalData, type: :model do
  describe 'calculate' do
    it 'should produce correct data' do
      run = create :run, :with_data
      summary = RunSummary.from_run run

      interval_data = IntervalData.new(RunDataStore.get(run.id))
      binding.pry
      expect(interval_data.length).to be(summary.total_time.to_i)
    end
  end
end
