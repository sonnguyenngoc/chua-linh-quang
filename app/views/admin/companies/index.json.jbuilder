json.array!(@companies) do |company|
  json.extract! company, :id, :image_url, :name, :head_office_address, :certificate_no, :date_of_issue, :sales_office_address, :phone, :hotline, :email
  json.url company_url(company, format: :json)
end
