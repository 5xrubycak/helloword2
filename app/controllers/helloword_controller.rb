class HellowordController < ApplicationController
  def index
    @setbox = Setbox.all
    @card = Card.all
  end

  def new
    @setbox = Setbox.new
    @card = Card.new
    # accept nested attribute for model , allow_destroy: true , reject:if
    # form for
    # gem cocoon
    # railscast
  end

  def create
    setbox_clean_params = params.require(:setbox).permit(:title)
    card_clean_params = params.require(:card).permit(:card_word, :card_def)

    @setbox = Setbox.new(setbox_clean_params)
    @card = Card.new(card_clean_params)
    
    if @setbox.save
      redirect_to root_path, notice: "新增setbox成功" 
    else
      render :new
    end
    
  end
end
