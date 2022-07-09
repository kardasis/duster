# Thin wrapper around AWS operations
class ColdDataStore < ApplicationRecord
  def self.store_raw_json(tickstamps, run)
    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    key = run.id

    s3.put_object({
                    body: raw_data_json(tickstamps, run.start_time.to_i),
                    bucket:,
                    key:
                  })
    s3_uri bucket, key
  end

  def self.raw_data_json(tickstamps, start_time)
    data_hash = {
      startTime: start_time,
      ticks: tickstamps
    }
    data_hash.to_json
  end

  def self.s3_uri(bucket, key)
    "https://#{bucket}.s3.amazonaws.com/#{key}"
  end

  def self.fetch_s3_data(bucket, key)
    s3 = Aws::S3::Client.new
    object = s3.get_object({ bucket:, key: })
    JSON.parse object
  end
end
