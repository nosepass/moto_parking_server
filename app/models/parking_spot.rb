class ParkingSpot < ActiveRecord::Base
  validates :name, :latitude, :longitude, :spaces, presence: true
end
