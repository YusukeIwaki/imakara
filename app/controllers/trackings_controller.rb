require 'GcmPush'

class TrackingsController < ApplicationController
  before_action :set_tracking, only: [:show]
  after_action :request_updating_location_log, only: [:show]

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
  
  private
  
  def set_tracking
    @tracking = Tracking.find_by!(id_code: params[:id])
  end
  
  def request_updating_location_log
    GcmPush.new(@tracking).request_updating_location_log_if_needed
  end
end