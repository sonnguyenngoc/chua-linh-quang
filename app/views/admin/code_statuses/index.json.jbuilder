json.array!(@code_statuses) do |code_status|
  json.extract! code_status, :id, :title, :description
  json.url code_status_url(code_status, format: :json)
end
