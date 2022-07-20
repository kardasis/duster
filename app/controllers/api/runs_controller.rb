# frozen_string_literal: true

module Api
  class RunsController < Api::ApiController
    def show
      run = Run.find(params[:id])
      render json: run
    end

    def create
      run = Run.create({ start_time: Time.now.utc.round })

      ActionCable.server.broadcast('new_runs', { msg: 'run_started', runId: run.id })
      render json: run
    end
  end
end
