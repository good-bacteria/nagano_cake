class Public::ShipsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @shipnew =Ship.new
    @ships =current_customer.ships
  end

  def create
    @shipnew = Ship.new(ship_params)
    @shipnew.customer_id = current_customer.id
    if @shipnew.save
       redirect_to ships_path
    else
      @ships = current_customer.ships
      render :index
    end
  end

  def edit
    @ship = Ship.find(params[:id])
  end

  def update
    @ship = Ship.find(params[:id])
    if @ship.update(ship_params)
      redirect_to ships_path
    else
      render "edit"
    end
  end

  def destroy
    ship = Ship.find(params[:id])
    ship.destroy
    redirect_to ships_path
  end

  private

  def ship_params
    params.require(:ship).permit(:customer_id,:postal_code,:address,:name)
  end


end