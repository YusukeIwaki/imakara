require 'GcmPush'

class Trackings::LocationLogsController < Trackings::BaseController
  after_action :notify_to_observers, only: [:create]
  
  def create
    location_log = @tracking.location_logs.create!(location_log_params)
    
    json_location_log = {
      id: location_log.id,
      lat: location_log.lat.to_f,
      lon: location_log.lon.to_f,
      accuracy: location_log.accuracy.to_f,
      created_at: location_log.created_at.to_i
    }
    render json: json_location_log, status: :created
  end
  
  private
  
  def location_log_params
    params.require(:location_log).permit(:lat, :lon, :accuracy)
  end
  
  def notify_to_observers
    GcmPush.new(@tracking).notify_latest_location_to_observers
  end
end