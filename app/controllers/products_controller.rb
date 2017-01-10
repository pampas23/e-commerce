class ProductsController < ApplicationController
	before_action :find_product
	
	def show
		@categories = Category.where(enable:true).all
	end

	def add
		if current_user
			@cart = find_cart 
			if @cart.cart_items.pluck(:product_id).include?(@product.id)
				@cart_item = find_cart_item(@product)
				@cart_item.add_item
			else
      	@cart.cart_items.create(:product_id => @product.id,:quantity =>1)
				redirect_to category_product_path(@product.category, @product)
			end
		end	
	end

	def destroy
		@cart_item = find_cart_item(@product)
		@cart_item.destroy
		redirect_to cart_path
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

	def find_cart_item(product)
		CartItem.find_by_product_id(product.id)
	end

end