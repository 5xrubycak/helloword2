class SetboxesController < ApplicationController
  def index
    @setbox = Setbox.all
  end

  def new
    @setbox = Setbox.new
  end

  def create
    setbox_clean_params = params.require(:setbox).permit(:title, cards_attributes: [:id, :card_word, :card_def ,:_destroy])
    @setbox = current_user.setboxes.build(setbox_clean_params)
    
    if @setbox.save
      redirect_to root_path, notice: "新增setbox成功" 
    else
      render :new, notice: "error"
    end
  end

  def show
    @setbox = Setbox.find_by(id: params[:id])
  end

  def edit
    @setbox = Setbox.find_by(id: params[:id])
  end

  def update
    @setbox = Setbox.find_by(id: params[:id])
    setbox_clean_params = params.require(:setbox).permit(:title, cards_attributes: [:id, :card_word, :card_def ,:_destroy])

    if @setbox.update(setbox_clean_params)
      redirect_to root_path, notice: "更新setbox成功"
    else
      render :edit
    end
  end
end
