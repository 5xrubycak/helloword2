class SetboxesController < ApplicationController

  before_action :find_setbox, only: [:show, :edit, :update, :answer]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @setbox = Setbox.all
    @setboxes = Setbox.joins(:cards).includes(:cards).search(params[:search]).sample(9)
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

  def copy
    @setbox = Setbox.find_by(id: params[:id])
    # dup_setbox=Setbox.find(6).dup
    # current_user.id
    @dup_setbox = @setbox.dup
    @dup_setbox.save
    @setbox.cards.each do |card|
    # dup_card=Card.find(71).dup
    dup_card = card.dup
    # dup_card.update(setbox_id:10)
    dup_card.setbox_id = Setbox.last.id #也是 Setbox.last.id
    dup_card.save
    # debugger
    @dup_setbox.user_id = current_user.id
    @dup_setbox.save
    # debugger
    end
    
    redirect_to home_setboxes_path, notice: "複製 #{@setbox.title}成功"
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
    @setboxes = Setbox.joins(:cards, :user).includes(:cards, :user).search(params[:search]).sample(9)
  end

  def pullreq
    @setboxes = Setbox.joins(:cards).includes(:cards).sample(1)
  end

  def write
    @setbox = Setbox.find_by(id: params[:id])
  end

  def judge
    @setbox = Setbox.find_by(id: params[:id])
    
      final_result = []
      params[:card].each do |key, value|
        # byebug
        @answer = params[:card]

        result = Card.find_by(id: key).card_def == value
        final_result << result
        # @faults << result
      end

      if final_result.count(false) != 0
        render :write
      else
        # redirect_to answer_setbox_path, notice: "全部答對!"
        respond_to do |format|

          format.js
        end
      end

  end

  def answer
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
