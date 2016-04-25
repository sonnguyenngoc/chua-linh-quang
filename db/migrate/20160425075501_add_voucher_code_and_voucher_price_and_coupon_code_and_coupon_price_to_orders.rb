class AddVoucherCodeAndVoucherPriceAndCouponCodeAndCouponPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :voucher_code, :string
    add_column :orders, :voucher_price, :decimal
    add_column :orders, :coupon_code, :string
    add_column :orders, :coupon_price, :decimal
  end
end
