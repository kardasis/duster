module Api
  class IntervalDataController < ApiController
    def show
      run = Run.find params[:run_id]
      bucket = ENV.fetch('AWS_S3_RAW_DATA_BUCKET_NAME', nil)
      key = "#{run.id}-interval"
      @second_data = ColdDataStore.fetch_s3_data(bucket, key)
      render json: @second_data
    end
  end
end
