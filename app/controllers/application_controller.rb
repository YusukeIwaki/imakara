class ApplicationController < ActionController::API
  class BadRequestError < StandardError
  end
    
  rescue_from BadRequestError do |err|
    render json: {}, status: :bad_request
  end

  rescue_from ActiveRecord::RecordInvalid do |err|
    render json: {}, status: :bad_request
  end
  
  rescue_from ActiveRecord::RecordNotFound do |err|
    render json: {}, status: :not_found
  end
end
