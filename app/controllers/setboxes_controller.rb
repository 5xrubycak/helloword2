class SetboxesController < ApplicationController

  before_action :find_setbox, only: [:show, :edit, :update, :pullreq]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @setbox = Setbox.all
    @setboxes = Setbox.joins(:cards).includes(:cards).search(params[:search]).sample(8)
  end

  def new
    @setbox = Setbox.new
  end

  def create
    @setbox = current_user.setboxes.build(setbox_params)
    
    if @setbox.save
      redirect_to home_setboxes_path, notice: "新增setbox成功" 
    else
      render :new, notice: "error"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @setbox.update(setbox_params)
      redirect_to home_setboxes_path, notice: "更新setbox成功"
    else
      render :edit
    end
  end

  def destroy
    @setbox = Setbox.find_by(id: params[:id])
    @setbox.destroy
    redirect_to home_setboxes_path, notice: "刪除資料"
  end

  def home
    @setbox = current_user.setboxes
  end

  def search
    @setboxes = Setbox.joins(:cards).includes(:cards).search(params[:search]).sample(8)
  end

  def pullreq
    @setboxes = Setbox.joins(:cards).includes(:cards).search(params[:search]).sample(1)
  end

  private

  def setbox_params
    setbox_clean_params = params.require(:setbox).permit(:title, cards_attributes: [:id, :card_word, :card_def ,:_destroy])
  end

  def find_setbox
    @setbox = Setbox.find_by(id: params[:id])
  end

  def check_login
    unless user_signed_in?
      redirect_to new_user_session_path, notice: '請先登入會員'
    end
  end
end
