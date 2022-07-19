# The channel in charge of sending data to the browser as it comes in
# from the iot device
class RunChannel < ApplicationCable::Channel
  def subscribed
    stream_for Run.find(params[:run_id])
  end
end
