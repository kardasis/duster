# frozen_string_literal: true

# Controller for runs
class Api::RunsController < Api::ApiController
  def create
    run = Run.new
    run.save!
    render json: run
  end
end
