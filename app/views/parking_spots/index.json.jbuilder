json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :description, :created_at
  json.url parking_spot_url(spot, format: :json)
end
