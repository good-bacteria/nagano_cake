class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def confirm
    # ご自身のご住所
    if params[:order][:address_type] == "customer_address"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    # 登録済住所から選択
    elsif params[:order][:address_type] == "ship_address"
      @order = Order.new(order_params)
      @ship = Ship.find(params[:order][:address_id])
      @order.postal_code = @ship.postal_code
      @order.address = @ship.address
      @order.name = @ship.name
    # 新しいお届け先
    elsif params[:order][:address_type] == "ship_address"
      @order = Order.new(order_params)
      # 新しいお届け先情報に空のパラメータが存在する場合、入力画面へ戻る
      if @order.postal_code.empty? || @order.address.empty? || @order.name.empty?
        redirect_to new_order_path
      end
    else
      redirect_to new_order_path
    end
    
    # カート情報
    @cart_items = current_customer.cart_items
    @total_price = 0
    
  end
  
  def thanks
  end
  
  def create
    redirect_to orders_thanks_path
  end
  
  def index
  end
  
  def show
  end
  
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
  
end
