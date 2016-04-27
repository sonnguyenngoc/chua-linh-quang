class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :order_detail_id
      t.integer :order_delivery_id

      t.timestamps null: false
    end
  end
end
