# frozen_string_literal: true

require 'rails_helper'

describe Api::RunSummariesController do
  describe 'POST run_summary' do
    it 'returns the summary' do
      run = create(:run, :with_data, :in_progress)

      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = run.id

      get :create, params: { run_id: run.id }

      expect(RunData.last.raw_data_uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}"
      expect(RunData.last.interval_data_uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}-interval"
    end
  end
end
