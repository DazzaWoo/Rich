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
    @token = gateway.client_token.generate
    
  end
  def cancel
    
  end

  private
  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: "use_your_merchant_id",
      public_key: "use_your_public_key",
      private_key: "use_your_private_key",
    )
  end
end
