class AddPriceToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :price, :decimal
  end
end
