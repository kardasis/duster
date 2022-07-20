# The channel in charge of sending data to the browser as it comes in
# from the iot device
class RunChannel < ApplicationCable::Channel
  def subscribed
    if params[:run_id].present?
      stream_for Run.find(params[:run_id])
    else
      stream_from 'new_runs'
    end
  end
end
