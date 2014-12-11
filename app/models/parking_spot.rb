class ParkingSpot < ActiveRecord::Base
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  validates :name, :latitude, :longitude, :spaces, presence: true
end
