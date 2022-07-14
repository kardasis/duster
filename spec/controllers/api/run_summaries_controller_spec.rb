# frozen_string_literal: true

require 'rails_helper'

describe Api::RunSummariesController do
  describe 'POST run_summary' do
    it 'returns the summary' do
      run = create(:run, :with_data)

      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = run.id

      get :create, params: { run_id: run.id }
      json = JSON.parse(response.body)

      expect(json['run_id']).to eq run.id
      expect(json['distance_records'].length).to be 2
      expect(RunSummary.last.raw_data_uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}"
      # expect(RunSummary.last.interval_data_uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}-interval"
    end
  end
end
