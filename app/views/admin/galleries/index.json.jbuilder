json.array!(@galleries) do |gallery|
  json.extract! gallery, :id, :title, :description, :gallery_image_id
  json.url gallery_url(gallery, format: :json)
end
