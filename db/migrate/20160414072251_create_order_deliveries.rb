class CreateOrderDeliveries < ActiveRecord::Migration
  def change
    create_table :order_deliveries do |t|
      t.string :first_name
      t.string :last_name
      t.string :company
      t.string :address
      t.string :city
      t.integer :zip_code
      t.string :country
      t.string :province
      t.integer :delivery_method_id
      t.integer :payment_method_id
      t.text :message

      t.timestamps null: false
    end
  end
end
