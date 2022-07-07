class RunSummariesController < ApplicationController
  def index
    @run_summaries = RunSummary.all
    render :index
  end
end
