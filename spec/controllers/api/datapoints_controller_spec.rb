# frozen_string_literal: true

require 'rails_helper'

describe Api::DatapointsController do
  describe 'POST add' do
    it 'updates redis' do
      post :add, params: { run_id: '123', data: '345,456,567' }

      expect(RunDataStore.get('123')).to eq [345, 456, 567]
    end
  end
end
