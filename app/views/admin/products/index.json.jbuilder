json.array!(@products) do |product|
  json.extract! product, :id, :name, :code, :quantity, :unit, :price, :short_description, :description, :category_id, :manufacturer_id, :product_image
  json.url product_url(product, format: :json)
end
