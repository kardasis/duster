namespace :import do
  desc 'fetch runs from the s3 bucket and write local summaries'
  task fetch_from_s3: :environment do
    pp 'pulling run data from s3'

    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
    bucket = 'arikardasis-runs'
    if bucket.nil?
      return
    end

    resp = s3.list_objects_v2({ bucket: })
    object_keys = resp.to_h[:contents].pluck(:key)
    valid_keys = object_keys.select { |k| k.match(/^run-\d*.json$/) }

    res = valid_keys.map { |key| RunSummary.from_s3_bucket bucket, key }
    pp "Pulled #{res.length} runs.  #{res.select(&:present?).count} new"
  end
end
