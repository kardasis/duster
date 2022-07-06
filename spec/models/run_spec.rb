# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Run, type: :model do
  describe 'create new record' do
    it 'should have a id' do
      run = create(:run)
      expect(run.id).to be_a_valid_uuid
    end
  end

  describe 'raw_data_json' do
    it 'should return a json string' do
      run = create(:run, :with_small_data)

      expectation = {
        'start_time' => run.start_time.to_i,
        'tickstamps' => [123, 345, 567]
      }
      expect(JSON.parse(run.raw_data_json)).to eq expectation
    end
  end
end
