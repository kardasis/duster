# frozen_string_literal: true

module Api
  class RunsController < Api::ApiController
    def show
      run = Run.find(params[:run][:id])
      render json: run
    end

    def create
      run = Run.new
      run.save!
      render json: run
    end
  end
end
