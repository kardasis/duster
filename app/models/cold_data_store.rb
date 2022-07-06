# Thin wrapper around AWS operations
class ColdDataStore < ApplicationRecord
  def self.store_raw_json(run)
    s3 = Aws::S3::Client.new
    s3.put_object body: run.raw_data_json,
                  bucket: ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil),
                  key: run.id
  end
end
