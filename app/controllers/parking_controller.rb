class ParkingController < ApplicationController
  def index
    @spots = ParkingSpot.all
    
  end
end
