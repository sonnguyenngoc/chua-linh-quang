class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :image_url
      t.string :name
      t.string :address
      t.text :description

      t.timestamps null: false
    end
  end
end
