module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError do |e|
      render json: { message: e.message }, status: :unauthorized
    end

    rescue_from ExceptionHandler::MissingToken do |e|
      render json: { message: e.message }, status: :unauthorized
    end

    rescue_from ExceptionHandler::InvalidToken do |e|
      render json: { message: e.message }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
