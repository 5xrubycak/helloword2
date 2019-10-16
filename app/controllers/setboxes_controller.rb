class SetboxesController < ApplicationController
  include SetboxesHelper
  # protect_from_forgery with: :null_session, only: [:json]
  # 錯誤的方法 下面的才是對的
  skip_before_action :verify_authenticity_token

  before_action :find_setbox, only: [:show, :edit, :update, :write, :judge]
  before_action :check_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @setbox = Setbox.all
    @setboxes = Setbox.joins(:cards).includes(:cards).search(params[:search]).sample(9)
  end

  def new
    @setbox = Setbox.new
    @card_text = params[:aa]
    @card_def_id = form_tag_id(@setbox, :card_word)

    # @result = translate_text(@card_text).text
    # byebug 
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
    @currentsetbox = current_user.setboxes.sample(5).uniq
    @othersetbox = Setbox.where.not(user_id: current_user.id).sample(5).uniq
    @suggestsetbox = current_user.setboxes.sample(2).uniq
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

  def lookup
    # @setbox = Setbox.new
    @def_id = params[:def_id]
    @word_id = params[:word_id]
    @card_text = params[:aa]
    @result = translate_text(@card_text).text
    # @object_name = sanitized_object_name(@setbox)
    # @card_def_id = form_tag_id(, :card_word)
    # debugger
    # byebug
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
    return @setboxes if @setboxes.count >= 1
    redirect_to noresult_setboxes_path
  end

  def noresult
  end

  def pullreq
    @setboxes = Setbox.joins(:cards).includes(:cards).sample(1)
  end

  def write
  end

  def judge
    @allwrong_answer = []
    @allright_answer = []
    params[:card].each do |key, value|
      # byebug
      card = Card.find_by(id: key)
      if verify_answer(card, value)
        @allright_answer << card
      else
        @allwrong_answer << card
      end
    end
    # puts "==================="
    # puts @allwrong_answer.map(&:id)
    # puts "==================="
    if @allwrong_answer.empty?
      respond_to do |format|
        format.js 
      end
    else
      respond_to do |format|
        format.js {render :write}
      end
    end
  end


  private

  def setbox_params
    setbox_clean_params = params.require(:setbox).permit(:title, :description, cards_attributes: [:id, :card_word, :card_def ,:_destroy])
  end

  def find_setbox
    @setbox = Setbox.find_by(id: params[:id])
  end

  def check_login
    unless user_signed_in?
      redirect_to new_user_session_path, notice: '請先登入會員'
    end
  end

  def verify_answer(card, value)
    card.card_def == value
  end
end