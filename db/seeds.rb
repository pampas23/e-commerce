# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = %w(Commerce Art Computer Food)

categories.each do |category_name|
	category = Category.create(name: category_name, discription: Faker::Lorem.sentences(rand(3..5)).join)
	rand(3..5).times do
		category.products.create(
			name: Faker::Commerce.product_name,
			discription: Faker::Lorem.sentences(rand(3..5)).join,
			content: Faker::Lorem.sentences(rand(3..5)).join,
			price: Faker::Commerce.price,
			active: true,
			on_sale: false
			)
		puts "create product in #{category_name}"
	end
end
