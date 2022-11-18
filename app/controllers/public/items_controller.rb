class Public::ItemsController < ApplicationController
  def index
    @items = Item.all 
    @genres = Grenre.all
  end 
  
  def show
  end
end
