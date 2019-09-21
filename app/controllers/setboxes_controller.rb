class SetboxesController < ApplicationController

  before_action :find_setbox, only: [:show, :edit, :update]
  def index
    @setbox = Setbox.all
  end

  def new
    @setbox = Setbox.new
  end

  def create
    @setbox = current_user.setboxes.build(setbox_params)
    
    if @setbox.save
      redirect_to root_path, notice: "新增setbox成功" 
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
      redirect_to root_path, notice: "更新setbox成功"
    else
      render :edit
    end
  end

  def destroy
    @setbox = Setbox.find_by(id: params[:id])
    @setbox.destroy
    redirect_to root_path, notice: "刪除資料"
  end

  private

  def setbox_params
    setbox_clean_params = params.require(:setbox).permit(:title, cards_attributes: [:id, :card_word, :card_def ,:_destroy])
  end

  def find_setbox
    @setbox = Setbox.find_by(id: params[:id])
  end
end
