class RunSummariesController < ApplicationController
  def index
    @run_summaries = RunSummary.order(created_at: :desc)
    render :index
  end

  def destroy
    rs = RunSummary.find params[:id]
    rs.destroy
  end

  def create
    run = Run.create(start_time: safe_params[:start_time])
    run.create_summary(safe_params)
    redirect_to run_summaries_path
  end

  def safe_params
    params.require(:run_summary).permit(:start_time, :total_distance, :total_time)
  end

  def new
    @run_summary = RunSummary.new start_time: Time.now
  end
end
