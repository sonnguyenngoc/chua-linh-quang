class AddDiscountPercentToProducts < ActiveRecord::Migration
  def change
    add_column :products, :discount_percent, :decimal
  end
end
