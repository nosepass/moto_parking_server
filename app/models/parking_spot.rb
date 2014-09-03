class ParkingSpot < ActiveRecord::Base
  enum type: [ :free, :paid ]
end
