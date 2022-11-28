class Admin::HomesController < ApplicationController
  def top
    if params[:customer_search]
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.page(params[:page]).per(10)
    else
      @orders = Order.page(params[:page]).per(10)
    end
  end
end
