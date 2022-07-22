class RunsController < ApplicationController
  def show
    if params[:id].blank?
      if Run.last.summary.nil?
        @run = Run.last
      end
    else
      @run = Run.find params[:id]
    end
  end
end
