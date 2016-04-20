json.array!(@areas) do |area|
  json.extract! area, :id, :name, :level, :description
  json.url area_url(area, format: :json)
end
