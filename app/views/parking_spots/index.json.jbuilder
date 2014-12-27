json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :description, :latitude, :longitude, :spaces, :paid, :created_at, :updated_at, :spots_available_date
  json.url parking_spot_url(spot, format: :json)
end
