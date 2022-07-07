# Thin wrapper around AWS operations
class ColdDataStore < ApplicationRecord
  def self.store_raw_json(run)
    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    key = run.id

    s3.put_object({
                    body: run.raw_data_json,
                    bucket:,
                    key:
                  })

    "https://#{bucket}.s3.amazonaws.com/#{key}"
  end
end
