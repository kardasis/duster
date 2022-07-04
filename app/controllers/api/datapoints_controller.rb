module Api
  class DatapointsController < ApiController
    def add
      run_id = params[:run_id]
      data = params[:data].split(',')
      RunDataStore.add(run_id, data)
    end
  end
end
