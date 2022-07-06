# frozen_string_literal: true

require 'rails_helper'

describe AwsClient, type: :model do
  describe 'put_run_to_s3' do
    it 'call the aws method' do
      s3_client = double(Aws::S3::Client)
      allow(Aws::S3::Client).to receive(:new).and_return(s3_client)
      allow(s3_client).to receive(:put_object)

      run = create :run, :with_small_data

      AwsClient.put_run_to_s3 run

      expect(s3_client).to have_received(:put_object)
    end
  end
end
