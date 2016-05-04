json.array!(@vouchers) do |voucher|
  json.extract! voucher, :id, :name, :code, :from_date, :to_date, :description, :quantity
  json.url voucher_url(voucher, format: :json)
end
