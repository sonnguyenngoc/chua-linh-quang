class AddPriceToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :price, :decimal
  end
end
