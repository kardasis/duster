# frozen_string_literal: true

require 'rails_helper'

describe Api::DatapointsController do
  describe 'POST add' do
    it 'should update redis' do
      run = create :run

      post :add, params: { run_id: run.id, data: '345,456,567' }

      expect(RunDataStore.get(run.id)).to eq [345, 456, 567]
    end
  end
end
