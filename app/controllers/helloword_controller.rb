class HellowordController < ApplicationController
  def index
    @setbox = Setbox.all
  end

  def new
    @setbox = Setbox.new
  end

  def create
    setbox_clean_params = params.require(:setbox).permit(:title, cards_attributes: [:id, :card_word, :card_def ,:_destroy])
    @setbox = Setbox.new(setbox_clean_params)
    
    if @setbox.save
      redirect_to root_path, notice: "新增setbox成功" 
    else
      render :new
    end
  end
end
