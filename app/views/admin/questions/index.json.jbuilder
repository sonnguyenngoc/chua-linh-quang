json.array!(@questions) do |question|
  json.extract! question, :id, :name, :email, :content, :product_id, :user_id
  json.url question_url(question, format: :json)
end
