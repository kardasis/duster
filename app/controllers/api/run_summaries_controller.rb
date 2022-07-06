module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      summary = run.create_run_summary
      ColdDataStore.store_raw_json run
      render json: summary
    end
  end
end
