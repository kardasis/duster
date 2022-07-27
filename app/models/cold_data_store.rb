# Thin wrapper around AWS operations
class ColdDataStore < ApplicationRecord
  def self.store_interval_json(run)
    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    key = "#{run.id}-interval"

    s3.put_object({ body: run.second_data.to_json, bucket:, key: })
    s3_uri bucket, key
  end

  def self.store_raw_json(run)
    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    key = run.id

    s3.put_object({
                    body: raw_data_json(run.tickstamps, run.start_time.to_i),
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
    begin
      res = JSON.parse s3.get_object({ bucket:, key: }).body.string, symbolize_names: true
      if res[:ticks].present?
        res[:ticks] = res[:ticks].map(&:to_i)
      end
      res
    rescue StandardError
      nil
    end
  end

  def self.remove_uri(uri)
    return if uri.blank?

    s3 = Aws::S3::Client.new

    parsed = URI.parse(uri)
    bucket = parsed.host.split('.')[0]
    key = parsed.path[1..]

    s3.delete_object bucket:, key:
  end
end
