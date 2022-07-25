namespace :import do
  desc 'fetch runs from the s3 bucket and write local summaries'
  task fetch_from_s3: :environment do
    pp 'pulling run data from s3'

    s3 = Aws::S3::Client.new
    bucket = ENV.fetch('AWS_S3_OLD_RAW_DATA_BUCKET_NAME', nil)
    if bucket.nil?
      return
    end

    resp = s3.list_objects_v2({ bucket: })
    object_keys = resp.to_h[:contents].pluck(:key)
    valid_keys = object_keys.select { |k| k.match(/^run-\d*.json$/) }

    res = valid_keys.map { |key| summary_from_s3_bucket bucket, key }
    pp "Pulled #{res.length} runs.  #{res.select(&:present?).count} new"
  end
end

def summary_from_s3_bucket(bucket, key)
  pp bucket, key

  start_time = key[/.*-(\d*)\.json/, 1]
  if start_time && RunSummary.exists?({ start_time: Time.at(start_time.to_i).utc })
    return nil
  end

  data = ColdDataStore.fetch_s3_data bucket, key

  run = Run.create_with_start_time data[:startTime].to_i / 1000

  run.tickstamps = data[:ticks]

  summary = run.generate_summary
  raw_data_uri = ColdDataStore.store_raw_json run
  summary.raw_data_uri = raw_data_uri

  interval_data_uri = ColdDataStore.store_interval_json run
  summary.interval_data_uri = interval_data_uri

  summary.save
  summary
end
