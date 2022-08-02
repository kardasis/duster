class RunSummariesController < ApplicationController
  def index
    @run_summaries = RunSummary.order(created_at: :desc)
    render :index
  end

  def destroy
    rs = RunSummary.find params[:id]
    ColdDataStore.remove_uri(rs.raw_data_uri)
    ColdDataStore.remove_uri(rs.interval_data_uri)
    rs.destroy
  end

  def duplicate
    new_rs = DuplicateRunSummary.call(params[:run_summary_id])
    render json: new_rs
  end
end
