class HellowordController < ApplicationController
  def index
    
  end

  def new
    @setbox = Setbox.new
    @card = Card.new
  end

  def create
    render html: 123
  end
end
