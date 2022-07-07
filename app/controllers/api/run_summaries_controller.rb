module Api
  class RunSummariesController < Api::ApiController
    def create
      run = Run.find params[:run_id]
      raw_data_uri = ColdDataStore.store_raw_json(run)
      summary = run.create_run_summary({ raw_data_uri: })

      # TODO: clean up here: remove data store (redis)
      render json: summary
    end
  end
end
