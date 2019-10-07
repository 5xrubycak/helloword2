class Api::V1::AuthenticationController < ApiController
  def login
    if valid_user?
      render json: { message: 'ok', auth_token: @user.auth_token}, status: 200
    else
      render json: { message: 'invalid user email or password'}, status: 401
    end
  end

  private

  def valid_user?
    @user = User.find_by(email: params[:email])
    return false if @user.blank?

    @user.valid_password?(params[:password])
    # valid_password? 是 Devise 提供的
  end
end
