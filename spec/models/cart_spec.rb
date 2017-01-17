require 'rails_helper'

RSpec.describe Cart,type: :model do
	describe "Cart" do
		before(:all) do
	    DatabaseCleaner.clean
	  end
	  let(:category) { FactoryGirl.create(:category)}
	  let(:product) { FactoryGirl.create(:product,:category_id => category.id)}
	  let(:user) { FactoryGirl.create(:user)}
	  let(:cart) { user.create_cart}

		it "empty?" do
			expect(cart.empty?).to eq(true)
			cart.cart_items.create(:product_id => product.id,:quantity =>1)
			expect(cart.empty?).to eq(false)
		end

		it "#total" do
			cart.cart_items.create(:product_id => product.id,:quantity =>1)
			product2 = FactoryGirl.create(:product, :category_id => category.id,:price => 30)
			cart.cart_items.create(:product_id => product2.id,:quantity =>2)
			expect(cart.total).to eq(160)
		end
	end

end