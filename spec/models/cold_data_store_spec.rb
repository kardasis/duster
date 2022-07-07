# frozen_string_literal: true

require 'rails_helper'

describe ColdDataStore, type: :model do
  describe 'store_raw_json' do
    it 'call the aws method' do
      s3_client = Aws::S3::Client.new
      run = create :run, :with_small_data

      uri = ColdDataStore.store_raw_json run

      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = run.id
      expect(uri).to eq "https://#{bucket}.s3.amazonaws.com/#{key}"
      expect(s3_client).to have_received(:put_object)
    end
  end
end
