# frozen_string_literal: true

require 'rails_helper'

describe IntervalData, type: :model do
  describe 'calculate' do
    it 'should produce correct data' do
      run = create :run, :with_data
      interval_data = IntervalData.new(run)

      expect(interval_data.length).to be(499)
    end
  end
end
