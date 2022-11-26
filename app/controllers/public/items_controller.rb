class Public::ItemsController < ApplicationController
  def index
    if params[:genre_search]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).per(8)
      @items_count = @genre.items.size
      @genres = Genre.all
    else
      @items = Item.page(params[:page]).per(8)
      @items_count = Item.all.size
      @genres = Genre.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
