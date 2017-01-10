class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_items, :dependent => :destroy

	 def empty?
    cart_items.empty?
  end
  
  def total
    cart_items.sum(&:subtotal)
  end
end
