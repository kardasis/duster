# Thin wrapper around AWS operations
class AwsClient < ApplicationRecord
  def self.put_run_to_s3(run)
    s3 = Aws::S3::Client.new
    s3.put_object body: run.raw_data_json,
                  bucket: ENV['AWS_S3_RAW_DATA_BUCKET_NAME'],
                  key: run.id
  end
end
