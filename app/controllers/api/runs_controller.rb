# frozen_string_literal: true

module Api
  class RunsController < Api::ApiController
    def show
      run = Run.find(params[:id])
      render json: run
    end

    def create
      run = Run.new({ start_time: Time.now.utc.round })
      run.save!
      render json: run
    end
  end
end
