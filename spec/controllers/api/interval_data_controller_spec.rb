require 'rails_helper'

describe Api::IntervalDataController do
  describe 'GET show' do
    it 'should return json' do
      data = (1..10).map do |_|
        { calories: 0.0923,
          immediate_speed: 7.65,
          time: 1234,
          distance: 1.234 }
      end

      run = create :run, :with_data
      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = "#{run.id}-interval"
      allow(ColdDataStore).to receive(:fetch_s3_data).with(bucket, key).and_return data

      get :show, params: { run_id: run.id }

      expect(JSON.parse(response.body).length).to eq(10)
    end
  end
end
