class RemoveCustomerIdAndOrderDetailIdAndOrderDeliveryIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :customer_id, :integer
    remove_column :orders, :order_detail_id, :integer
    remove_column :orders, :order_delivery_id, :integer
  end
end
