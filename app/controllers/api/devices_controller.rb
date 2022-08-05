module Api
  class DevicesController < ApiController
    def connect
      mac_address = params[:mac_address]
      Rails.logger.info "device connected: #{mac_address}"
    end
  end
end
