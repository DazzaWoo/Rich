class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @order = Order.new
  end
  def create
    if 
      redirect_to pay_order_path(id: order.serial)
    else
      redirect_to plans_path, notice: "訂單建立失敗"
    end
  end
  def pay
    @order = Order.find_by!(serial: params[:id])
  end
  def cancel
    
  end
end
