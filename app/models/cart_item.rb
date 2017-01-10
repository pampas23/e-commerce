class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product

	def subtotal
		quantity * product.price
	end

	def add_item
		self.increment(:quantity,by=1)
		self.save
	end
end
