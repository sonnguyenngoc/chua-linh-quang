class AddVoucherCodeToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :voucher_code, :string
  end
end
