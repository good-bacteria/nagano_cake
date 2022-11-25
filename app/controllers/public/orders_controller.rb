class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    # ご自身のご住所
    if params[:order][:address_type] == "customer_address"
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    # 登録済住所から選択
    elsif params[:order][:address_type] == "ship_address"
      @order = Order.new(order_params)
      @ship = current_customer.ships.find(params[:order][:address_id])
      @order.postal_code = @ship.postal_code
      @order.address = @ship.address
      @order.name = @ship.name
    # 新しいお届け先
    elsif params[:order][:address_type] == "new_address"
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
    @order = Order.new(confirmed_order_params)
    @order.customer_id = current_customer.id

    if @order.save

      # カート商品を注文商品(OrderItems)テーブルへ登録
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.item_id = cart_item.item_id
        order_item.price = cart_item.item.price_add_tax
        order_item.amount = cart_item.amount
        order_item.save
      end

      # カート商品を全削除
      current_customer.cart_items.destroy_all

      redirect_to orders_thanks_path
    else
      # カート情報
      @cart_items = current_customer.cart_items
      @total_price = 0

      render "confirm"
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  def confirmed_order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

end
