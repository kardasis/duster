require 'rails_helper'

describe IntervalData, type: :model do
  describe 'calculate' do
    it 'should produce correct data' do
      run = create :run, :with_data
      interval_data = IntervalData.new(run)

      expect(interval_data.length).to be(499)
    end
  end

  describe '#total_calories' do
    it 'should sum the calories' do
      run = create :run, :with_data
      interval_data = IntervalData.new(run)

      expect(interval_data.total_calories).to be_within(0.1).of(157.0)
    end
  end
end
