class OrdersController < ApplicationController
	before_action :find_cart
	def new
    @order = current_user.orders.new(email: current_user.email)
	end

  def create
    @order = current_user.orders.new(order_params)
    @order.add_items(current_user.cart)
    if @order.save
      current_user.cart.destroy
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def show
  	@order = find_order
  end

  def checkout
    @order = current_user.orders.find(params[:id])
    if @order.paid?
      redirect_to :back, alert: 'The order was paid'
    else
      @payment = @order.payments.create!(payment_method: params[:payment_method])
      render layout: false
    end
  end
  
  private

  def order_params
    params.require(:order).permit(
      :name, :email, :mobile, :address
    )
  end

  def find_cart
  	@cart = current_user.cart
  end

  def find_order
  	Order.find_by_id(params[:id])
  end
end
