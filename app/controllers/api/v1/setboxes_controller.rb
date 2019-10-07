class Api::V1::SetboxesController < ApiController
  before_action :authenticate_user_token

  def index 
    render json: current_user.setboxes
  end

end