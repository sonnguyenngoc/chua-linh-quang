json.array!(@comment_articles) do |comment_article|
  json.extract! comment_article, :id, :name, :email, :content, :user_id, :article_id
  json.url comment_article_url(comment_article, format: :json)
end
