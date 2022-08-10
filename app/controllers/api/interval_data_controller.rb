module Api
  class IntervalDataController < ApiController
    def show
      run = Run.find params[:run_id]
      render json: run.second_data
    end
  end
end
