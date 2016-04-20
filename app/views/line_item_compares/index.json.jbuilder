json.array!(@line_item_compares) do |line_item_compare|
  json.extract! line_item_compare, :id, :product_id, :compare_id
  json.url line_item_compare_url(line_item_compare, format: :json)
end
