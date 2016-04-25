json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :name, :code, :from_date, :to_date, :description, :quantity
  json.url coupon_url(coupon, format: :json)
end
