# frozen_string_literal: true

require 'rails_helper'

describe ColdDataStore, type: :model do
  describe 'store_raw_json' do
    it 'call the aws method' do
      s3_client = double(Aws::S3::Client)
      allow(Aws::S3::Client).to receive(:new).and_return(s3_client)
      allow(s3_client).to receive(:put_object)

      run = create :run, :with_small_data

      ColdDataStore.store_raw_json run

      expect(s3_client).to have_received(:put_object)
    end
  end
end
