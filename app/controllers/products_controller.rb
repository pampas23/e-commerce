class ProductsController < ApplicationController
	before_action :find_product
	
	def show
		@categories = Category.where(enable:true).all
	end

	private
	def find_product
		@product = Product.find(params[:id])
	end
end