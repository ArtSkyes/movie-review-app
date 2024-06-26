class ApplicationController < ActionController::API
  include ExceptionHandler
  before_action :authenticate_request
  attr_reader :current_user

  private

  def authenticate_request
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true,
                                   algorithm: "HS256")
        @current_user = User.find(decoded_token[0]["user_id"])
      rescue JWT::DecodeError
        render json: { error: "Invalid token" }, status: :unauthorized
      end
    else
      render json: { error: "Missing token" }, status: :unauthorized
    end
  end
end
