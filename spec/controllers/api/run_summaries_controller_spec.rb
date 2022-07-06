# frozen_string_literal: true

require 'rails_helper'

describe Api::RunSummariesController do
  describe 'POST run_summary' do
    it 'returns the summary' do
      run = create(:run, :with_data)

      get :create, params: { run_id: run.id }
      json = JSON.parse(response.body)

      expect(json['run_id']).to eq run.id
      expect(json['distance_records'].length).to be 2
    end
  end
end
