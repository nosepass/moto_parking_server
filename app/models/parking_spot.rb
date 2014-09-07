class ParkingSpot < ActiveRecord::Base
  validates :name, :latitude, :longitude, :type, :spaces, presence: true
end
