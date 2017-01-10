class CartsController < ApplicationController
	def show
		@user = current_user
		@cart = find_cart
		@cart.user_id = current_user
	end

	def destroy
			@cart = find_cart
			@cart.destroy
			redirect_to cart_path
	end	

	private

	def find_cart
		if current_user.cart.present?
			Cart.includes(:cart_items => [:product =>[:category]]).find_by_user_id(current_user.id)
		else
			Cart.new
		end	
	end
end
