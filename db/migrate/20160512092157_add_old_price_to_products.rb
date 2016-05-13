class AddOldPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :old_price, :decimal
  end
end
