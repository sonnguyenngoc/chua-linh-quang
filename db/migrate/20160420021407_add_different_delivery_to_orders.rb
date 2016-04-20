class AddDifferentDeliveryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :different_delivery, :boolean, default: false
  end
end
