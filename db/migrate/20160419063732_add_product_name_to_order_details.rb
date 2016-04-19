class AddProductNameToOrderDetails < ActiveRecord::Migration
  def change
    add_column :order_details, :product_name, :string
  end
end
