# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RunDataStore, type: :model do
  describe 'add' do
    it 'should update internal data' do
      run_id = 'abc'
      RunDataStore.add run_id, [34, 123]

      expect(RunDataStore.get(run_id)).to eq [34, 123]
    end
  end
end
