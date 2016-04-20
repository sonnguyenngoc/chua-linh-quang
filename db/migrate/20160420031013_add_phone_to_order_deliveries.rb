class AddPhoneToOrderDeliveries < ActiveRecord::Migration
  def change
    add_column :order_deliveries, :phone, :string
  end
end
