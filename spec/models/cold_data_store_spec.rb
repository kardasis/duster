# frozen_string_literal: true

require 'rails_helper'

describe ColdDataStore, type: :model do
  describe '.store_raw_json' do
    it 'should call the aws method' do
      s3_client = Aws::S3::Client.new
      run = create :run, :with_small_data

      uri = ColdDataStore.store_raw_json run

      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = run.id
      expect(uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}"
      expect(s3_client).to have_received(:put_object)
    end
  end

  describe '.fetch_raw_data' do
    it 'should return a hash object of the data' do
      s3_client = Aws::S3::Client.new
      json_data_string = { 'start_time' => 1_657_310_628, 'ticks' => [123, 987, 1234] }.to_json
      key = 'abcd'
      bucket = 'xyz'
      allow(s3_client).to receive_message_chain(:get_object, :body, :string).and_return(json_data_string)

      result = ColdDataStore.fetch_s3_data(bucket, key)

      expect(result['start_time']).to eq 1_657_310_628
      expect(result['ticks']).to eq [123, 987, 1234]
    end
  end
end
