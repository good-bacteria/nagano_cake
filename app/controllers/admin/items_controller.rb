class Admin::ItemsController < ApplicationController
  
  def index
    @items = Item.all
  end
    
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item =Item.new(item_params)
    if @item.save
      flash[:notice] = "商品の新規登録に成功しました"
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "商品の新規登録に失敗しました"
      @genres = Genre.all
      render:new
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
     flash[:notice] = "商品の編集に成功しました"
     redirect_to admin_item_path
    else
     @genres = Genre.all
     render :edit
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end
  
end
