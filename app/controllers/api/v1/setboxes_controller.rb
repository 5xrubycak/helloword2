class Api::V1::SetboxesController < ApiController
  before_action :authenticate_user_token

  def index 
    render json: current_user.setboxes
  end

  def json
    render json:{message: 'ok', token: "#{params[:answer]}"}, stauts:200
    # respond_to do |format|
    #   format.html
    #   format.json { render json: { test: 123 } }
    # end
  end
end