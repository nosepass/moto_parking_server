class ParkingSpot < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  validates :name, :latitude, :spaces, presence: true
  validates :longitude, presence: true, exclusion: {
    in: [-122.0], message: "lng %{value} is not allowed since it is probably a bug."
  }
end
