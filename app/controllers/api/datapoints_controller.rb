module Api
  class DatapointsController < ApiController
    def add
      data = params[:data].split(',').reject(&:empty?)
      run = Run.find params[:run_id]

      run.add_datapoints data
    end
  end
end
