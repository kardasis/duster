require 'rails_helper'

describe BestTimeForDistance, type: :model do
  describe '#calculate' do
    it 'should return the best time' do
      normalized_data = (0..1500).map { |i| 50 * i }
      btfd = BestTimeForDistance.new(normalized_data).calculate(miles: 0.1)

      expect(btfd[:start_time]).to eq 0
      expect(btfd[:start_index]).to eq 0
      expect(btfd[:end_index]).to eq (0.1 * TICKS_PER_MILE).round
      expect(btfd[:end_time]).to eq normalized_data[btfd[:end_index]].round
    end
  end
end
