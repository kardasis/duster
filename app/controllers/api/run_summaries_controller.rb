module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      run.generate_summary

      raw_data_uri = ColdDataStore.store_raw_json run
      run.summary.raw_data_uri = raw_data_uri

      interval_data_uri = ColdDataStore.store_interval_json run
      run.summary.interval_data_uri = interval_data_uri

      run.summary.save
      render json: run.summary
    end
  end
end
