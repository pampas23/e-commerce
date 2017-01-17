require 'rails_helper'

RSpec.describe Order,type: :model do
	describe "Order" do
		before(:all) do
	    DatabaseCleaner.clean
	  end
	  let(:category) { FactoryGirl.create(:category)}
	  let(:product) { FactoryGirl.create(:product,:category_id => category.id)}
	  let(:user) { FactoryGirl.create(:user)}
	  let(:cart) { user.create_cart}

		it "#add_item(cart)" do
			cart_item = cart.cart_items.create(:product_id => product.id,:quantity =>3)
			order = user.orders.new(:user_id => user.id,:email => user.email, :name=>"user",:mobile=> "0987654321")
			order.add_items(cart)
			expect(order.amount).to eq(300)
		end
	end
end