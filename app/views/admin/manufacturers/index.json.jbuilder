json.array!(@manufacturers) do |manufacturer|
  json.extract! manufacturer, :id, :image_url, :name, :address, :description
  json.url manufacturer_url(manufacturer, format: :json)
end
