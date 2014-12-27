class AddFullnessDateToParkingSpot < ActiveRecord::Migration
  def change
    add_column :parking_spots, :spots_available_date, :timestamp
  end
end
