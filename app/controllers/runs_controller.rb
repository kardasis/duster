class RunsController < ApplicationController
  def show
    return if params[:id].blank?

    @run = Run.find params[:id]
  end
end
