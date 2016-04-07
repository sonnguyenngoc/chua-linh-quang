class CreateAreasProducts < ActiveRecord::Migration
  def change
    create_table :areas_products do |t|
      t.integer :area_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
