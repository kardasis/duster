class RunSummariesController < ApplicationController
  def index
    @run_summaries = RunSummary.order(created_at: :desc)
    render :index
  end

  def destroy
    rs = RunSummary.find params[:id]
    rs.destroy
  end

  def duplicate
    old_rs = RunSummary.find params[:run_summary_id]
    run = Run.create_with_start_time Time.now.utc

    new_rs = RunSummary.new({ run:,
                              total_time: old_rs.total_time,
                              total_distance: old_rs.total_distance,
                              start_time: old_rs.start_time })

    new_rs.save
    render json: new_rs
  end
end
