module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      run.generate_summary

      ColdDataStore.store_raw_json run
      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = run.id
      raw_data_uri = ColdDataStore.s3_uri bucket, key

      run.summary.raw_data_uri = raw_data_uri

      run.summary.save

      render json: run.summary
    end
  end
end
