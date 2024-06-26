class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Entry point - return valid user object
  def call
    {
      user:
    }
  end

  private

  attr_reader :headers

  def user
    # Check if user is in the database
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    # Handle user not found
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  # Decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  # Check for token in 'Authorization' headers
  def http_auth_header
    return headers["Authorization"].split(" ").last if headers["Authorization"].present?

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
