class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_items

	 def empty?
    cart_items.empty?
  end
end
