module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      summary = run.create_run_summary
      AwsClient.put_run_to_s3 run
      render json: summary
    end
  end
end
