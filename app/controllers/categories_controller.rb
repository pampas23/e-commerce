class CategoriesController < ApplicationController
	before_action :find_category

	def show
		@products = Product.where(category_id: @category).page(params[:page])
		@categories = Category.where(enable:true).all
	end

	private
	def find_category
		@category = Category.find(params[:id])
	end
end