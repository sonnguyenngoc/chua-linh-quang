class CreateDeliveryMethods < ActiveRecord::Migration
  def change
    create_table :delivery_methods do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
