# frozen_string_literal: true

module Api
  class RunsController < Api::ApiController
    def create
      run = Run.new
      run.save!
      render json: run
    end
  end
end
