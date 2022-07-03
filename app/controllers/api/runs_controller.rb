class Api::RunsController < Api::ApiController
  def create
    run = Run.new
    run.save!
    render json: run
  end
end
