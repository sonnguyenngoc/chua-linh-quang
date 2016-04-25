json.array!(@slideshows) do |slideshow|
  json.extract! slideshow, :id, :image_url, :title_1, :title_2, :name_button, :link
  json.url slideshow_url(slideshow, format: :json)
end
