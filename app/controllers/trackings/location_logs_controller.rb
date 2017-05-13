require 'GcmPush'

class Trackings::LocationLogsController < Trackings::BaseController
  after_action :notify_to_observers, only: [:create]
  
  def create
    location_log = @tracking.location_logs.create!(location_log_params)
    
    json_location_log = location_log.slice(:id, :lat, :lon, :accuracy, :created_at)
    json_location_log[:created_at] = json_location_log[:created_at].to_i
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