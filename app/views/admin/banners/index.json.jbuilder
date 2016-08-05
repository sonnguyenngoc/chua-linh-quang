json.array!(@banners) do |banner|
  json.extract! banner, :id, :image_url, :title, :banner_type
  json.url banner_url(banner, format: :json)
end
