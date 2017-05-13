require 'fcm'

class GcmPush
  def initialize(tracking)
    @tracking = tracking
    @fcm = FCM.new(Rails.application.secrets.fcm_api_key)
  end

  def request_updating_location_log_if_needed
    return if recently_updated?
    
    receivers = [@tracking.owner.gcm_token]
    payload = {
      data: {
        push_type: :update_location_log,
        tracking_id: @tracking.id_code
      }
    }
    
    response = @fcm.send(receivers, payload)
    Rails.logger.debug JSON::parse(response[:body])
  end
  
  def notify_latest_location_to_observers
    receivers = [@tracking.owner.gcm_token]
    payload = {
      data: {
        push_type: :new_location_log,
        tracking: tracking_json
      }
    }
    
    response = @fcm.send(receivers, payload)
    Rails.logger.debug JSON::parse(response[:body])
  end
  
  private
  
  def recently_updated?
    @tracking.location_logs.where('created_at >= ?', 20.seconds.ago).exists?
  end
  
  def tracking_json
    location_log = @tracking.location_logs.last
    json_location_log = location_log.blank? ? nil : {
      id: location_log.id,
      lat: location_log.lat.to_f,
      lon: location_log.lon.to_f,
      accuracy: location_log.accuracy.to_f,
      created_at: location_log.created_at.to_i
    }
    
    { id: @tracking.id_code, location_log: json_location_log, updated_at: @tracking.updated_at.to_i }
  end
end