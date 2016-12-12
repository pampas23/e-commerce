class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
    	t.integer :category_id
    	t.string :name
    	t.string :discription
    	t.text :content
    	t.integer :price
    	t.boolean :active
    	t.boolean :on_sale

      t.timestamps
    end
  end
end
