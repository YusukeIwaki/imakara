require 'GcmPush'
require 'googlestaticmap'

class TrackingsController < ApplicationController
  include ActionController::MimeResponds
  
  before_action :set_tracking, only: [:show, :location, :destroy]
  after_action :request_updating_location_log, only: [:show, :location]

  def create
    user_params = params.require(:user).permit(:name, :gcm_token)
    raise BadRequestError if user_params[:gcm_token].blank?

    ApplicationRecord.transaction do
      user = User.find_or_initialize_by(user_params)
      user.save!
      @tracking = user.trackings.order(:updated_at).reverse_order.first_or_create!
    end

    json_tracking = @tracking.slice(:id_code)
    json_tracking[:id] = json_tracking.delete(:id_code)
    render json: json_tracking, status: :ok
  end
  
  def show
    location_log = @tracking.location_logs.recent_enough_for_cached_view.last.try(:decorate)
    json_location_log = location_log.try(:attributes_for_json_response)

    tracking = @tracking.decorate
    render json: { id: tracking.id_code, location_log: json_location_log, updated_at: tracking.updated_at }
  end
  
  def location
    location_log = @tracking.location_logs.recent_enough_for_cached_view.last.try(:decorate)
    if location_log.present?
      send_data gmap(location_log.lat, location_log.lon, location_log.accuracy).get_map, type: 'image/png', disposition: 'inline' and return
    else
      render nothing: true, status: :no_content
    end
  end
  
  def destroy
    user_params = params.require(:user).permit(:name, :gcm_token)
    raise BadRequestError if user_params[:gcm_token].blank?
    user = User.find_by!(user_params)

    if @tracking.owner == user
      @tracking.destroy
      render nothing: true, status: :no_content
    else
      render nothing: true, status: :forbidden
    end
  end
  
  private
  
  def set_tracking
    @tracking = Tracking.find_by!(id_code: params[:id])
  end
  
  def request_updating_location_log
    GcmPush.new(@tracking).request_updating_location_log_if_needed
  end
  
  def gmap(lat, lon, accuracy)
    width = 600
    height = 256

    GoogleStaticMap.new(
      zoom: calculate_zoom_by_accuracy(height, accuracy),
      center: MapLocation.new(latitude: lat, longitude: lon),
      width: width,
      height: height
    ).tap { |map|
      poly = MapPolygon.new(color: "0x007AFFCC", weight: 1, fillcolor: "0x007AFF44")
      poly_points(lat, lon, accuracy).each do |point|
        poly.points << point
      end
      map.paths << poly
      map.markers << MapMarker.new(location: MapLocation.new(latitude: lat, longitude: lon))
    }
  end
  
  def calculate_zoom_by_accuracy(screen_size, accuracy)
    required_mpp = 10 * accuracy/screen_size
    zoom_level = 1 + Math.log(40075004 / (256 * required_mpp)) / Math.log(2)
    
    [1, [zoom_level.to_i, 20].min].max
  end
  
  def poly_points(lat, lon, accuracy)
    radius_degree = 0.00001 * accuracy / 1.1132
    (0..360).step(6)
      .map{|deg| deg * Math::PI / 180}
      .map{|rad| MapLocation.new(latitude: lat+radius_degree*Math.cos(rad), longitude: lon+radius_degree*Math.sin(rad))}
  end
end