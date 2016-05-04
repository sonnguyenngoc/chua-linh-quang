json.array!(@wish_lists) do |wish_list|
  json.extract! wish_list, :id, :product_id, :user_id
  json.url wish_list_url(wish_list, format: :json)
end
