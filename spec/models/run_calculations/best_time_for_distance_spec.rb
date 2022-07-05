# frozen_string_literal: true

require 'rails_helper'

describe BestTimeForDistance, type: :model do
  describe 'calculate' do
    it 'should return the best time' do
      normalized_data = (0..1500).map { |i| 50 * i }
      btfd = BestTimeForDistance.new(normalized_data).calculate(miles: 0.1)

      expect(btfd[:start_time]).to eq 0
      expect(btfd[:start_index]).to eq 0
      expect(btfd[:end_index]).to eq (0.1 * RunSummary.ticks_per_mile).round
      expect(btfd[:start_distance]).to eq 0
      expect(btfd[:end_distance]).to be_within(0.001).of(0.1)
      expect(btfd[:time]).to be_within(0.1).of(0.1 * RunSummary.ticks_per_mile * 0.05)
    end
  end
end
