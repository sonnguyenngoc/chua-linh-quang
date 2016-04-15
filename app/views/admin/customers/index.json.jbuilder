json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name, :email, :phone, :company, :address, :city, :zip_code, :country, :province
  json.url customer_url(customer, format: :json)
end
