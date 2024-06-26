class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: :authenticate

  def sign_up
    user = User.new(user_params)
    if user.save
      token = generate_token(user)
      render json: { token: }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def sign_in
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def authenticate
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def generate_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
