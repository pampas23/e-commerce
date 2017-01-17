require 'rails_helper'

RSpec.describe CartItem,type: :model do
	describe "Cart_item" do
		before(:all) do
	    DatabaseCleaner.clean
	  end
	  let(:category) { FactoryGirl.create(:category)}
	  let(:product) { FactoryGirl.create(:product,:category_id => category.id)}
	  let(:user) { FactoryGirl.create(:user)}
	  let(:cart) { user.create_cart}

		it "#subtotal" do
			cart_item = cart.cart_items.create(:product_id => product.id,:quantity =>2)
			expect(cart_item.subtotal).to eq(200)
		end

		it "#add_item" do
			cart_item = cart.cart_items.create(:product_id => product.id,:quantity =>1)
			cart_item.add_item
			expect(cart_item.quantity).to eq(2)
		end
	end

end