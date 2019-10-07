class Api::V1::AuthenticationController < ApiController
  before_action :authenticate_user_token, only: :logout

  def login
    if valid_user?
      render json: { message: 'ok', auth_token: @user.auth_token}, status: 200
    else
      render json: { message: 'invalid user email or password'}, status: 401
    end
  end

  def logout
    current_user.regenerate_auth_token
    render json: { message: 'you have been logged out'}, status: 200
  end

  private

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?

    @user.valid_password?(params[:password])
    # valid_password? 是 Devise 提供的
  end
end
