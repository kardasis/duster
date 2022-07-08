module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      summary = RunSummary.from_run run

      RunDataStore.remove(run.id)
      render json: summary
    end
  end
end
