json.array!(@albums) do |album|
  json.extract! album, :id, :image_url, :title, :description, :link, :user_id
  json.url album_url(album, format: :json)
end
