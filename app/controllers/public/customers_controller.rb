class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      render :edit
    end   
  end
  
  def quit
  end
  
  # テスト用にif 文で退会or有効に変更できる
  # 退会後の挙動を追加予定
  def withdraw
    @customer = current_customer
    if @customer.is_deleted == false
      @customer.update(is_deleted: true)
    else
      @customer.update(is_deleted: false)
    end
    redirect_to customers_my_page_path
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end

end
