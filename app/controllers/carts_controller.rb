class CartsController < ApplicationController
	def show
		@user = current_user
		@cart = find_cart
		@cart.user_id = current_user
	end

	private
	def find_cart
		if current_user.cart.present?
			current_user.cart
		else
			Cart.new
		end	
	end
end
