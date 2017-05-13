class Trackings::ObservesController < Trackings::BaseController
  def create
    ApplicationRecord.transaction do
      user = User.find_or_create_by!(user_params)
      raise BadRequestError if @tracking.owner == user
      
      @observation = @tracking.observations.find_or_initialize_by(user: user)
      @observation.updated_at = Time.current
      @observation.save!(touch: false)
    end
    
    json_observation = @observation.decorate.slice(:tracking_id, :user, :updated_at)
    render json: json_observation, status: :ok
  end
  
  def destroy
    user = User.find_by!(user_params)
    ApplicationRecord.transaction do
      @tracking.observations.where(user: user).destroy_all
      user.destroy unless Observation.where(user: user).exists?
    end
    render nothing: true, status: :no_content
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :gcm_token)
  end
end