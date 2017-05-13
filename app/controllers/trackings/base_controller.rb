class Trackings::BaseController < ApplicationController
  before_action :set_tracking

  private

  def set_tracking
    @tracking = Tracking.find_by!(id_code: params[:tracking_id])
  end
end