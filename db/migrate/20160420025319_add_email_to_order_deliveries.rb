class AddEmailToOrderDeliveries < ActiveRecord::Migration
  def change
    add_column :order_deliveries, :email, :string
  end
end
