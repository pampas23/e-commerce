class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy
  has_many :payments, dependent: :destroy

	validates_presence_of :name, :email, :amount

  def add_items(cart)
    self.transaction do
      self.amount ||= 0
      cart.cart_items.each do |cart_item|
        oi = order_items.build(
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
        self.amount += oi.subtotal
      end
    end
  end	
end