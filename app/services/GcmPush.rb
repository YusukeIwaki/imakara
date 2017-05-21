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
        tracking: {
          id: @tracking.id_code
        }
      },
      collapse_key: :update_location_log,
      priority: :high
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
      },
      collapse_key: :new_location_log
    }
    
    response = @fcm.send(receivers, payload)
    Rails.logger.debug JSON::parse(response[:body])
  end
  
  private
  
  def recently_updated?
    @tracking.location_logs.where('created_at >= ?', 20.seconds.ago).exists?
  end
  
  def tracking_json
    location_log = @tracking.location_logs.last.try(:decorate)
    json_location_log = location_log.try(:attributes_for_json_response)
    
    tracking = @tracking.decorate

    { id: tracking.id_code, location_log: json_location_log, updated_at: @tracking.updated_at }
  end
end