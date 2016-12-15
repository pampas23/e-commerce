class ProductsController < ApplicationController
	before_action :find_product
	
	def show
		@categories = Category.where(enable:true).all
	end

	def add
		if current_user
			@cart = find_cart
			@cart.cart_items.create(:product_id => @product.id)
			redirect_to category_product_path(@product.category, @product)
		else

		end	
	end

	private
	def find_product
		@product = Product.find(params[:id])
		@category = Category.find(params[:category_id])
	end

	def find_cart
		if current_user.cart
			current_user.cart
		else
			Cart.create( :user => current_user )
		end	
	end

end