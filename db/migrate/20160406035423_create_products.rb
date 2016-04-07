class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.decimal :quantity
      t.string :unit
      t.decimal :price
      t.text :short_description
      t.text :description
      t.integer :manufacturer_id
      t.integer :product_image_id

      t.timestamps null: false
    end
  end
end
