module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      run.generate_summary

      raw_data_uri = ColdDataStore.store_raw_json run
      interval_data_uri = ColdDataStore.store_interval_json run

      run.create_run_data raw_data_uri:, interval_data_uri:, run_id: run.id

      run.summary.save
      render json: run.summary
    end

    def show
      summary = RunSummary.find params[:id]
      render json: summary
    end
  end
end
