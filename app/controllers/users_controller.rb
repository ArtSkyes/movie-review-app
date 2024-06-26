class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token:, token_type: "Bearer" }
    render json: response, status: :created
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
