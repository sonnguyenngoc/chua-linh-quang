json.array!(@article_categories) do |article_category|
  json.extract! article_category, :id, :name, :description
  json.url article_category_url(article_category, format: :json)
end
