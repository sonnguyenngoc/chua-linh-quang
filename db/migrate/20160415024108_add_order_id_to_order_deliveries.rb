class AddOrderIdToOrderDeliveries < ActiveRecord::Migration
  def change
    add_column :order_deliveries, :order_id, :integer
  end
end
