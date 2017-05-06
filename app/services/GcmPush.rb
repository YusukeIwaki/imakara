class GcmPush
  def initialize(tracking)
    @tracking = tracking
  end

  def request_updating_location_log_if_needed
    return if recently_updated?
    
    binding.pry
  end
  
  private
  
  def recently_updated?
    @tracking.location_logs.where('created_at >= ?', 20.seconds.ago).exists?
  end
end