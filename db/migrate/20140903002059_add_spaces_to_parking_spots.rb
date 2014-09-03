class AddSpacesToParkingSpots < ActiveRecord::Migration
  def change
    add_column :parking_spots, :spaces, :integer
  end
end
