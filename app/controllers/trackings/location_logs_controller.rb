require 'GcmPush'

class Trackings::LocationLogsController < Trackings::BaseController
  after_action :notify_to_observers, only: [:create]
  
  def create
    location_log = @tracking.location_logs.create!(location_log_params).decorate
    
    render json: location_log.attributes_for_json_response, status: :created
  end
  
  private
  
  def location_log_params
    params.require(:location_log).permit(:lat, :lon, :accuracy)
  end
  
  def notify_to_observers
    GcmPush.new(@tracking).notify_latest_location_to_observers
  end
end