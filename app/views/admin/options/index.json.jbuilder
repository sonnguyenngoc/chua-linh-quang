json.array!(@options) do |option|
  json.extract! option, :id, :home_title, :home_meta_keywords, :home_meta_description
  json.url option_url(option, format: :json)
end
