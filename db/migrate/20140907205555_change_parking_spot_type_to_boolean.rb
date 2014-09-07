class ChangeParkingSpotTypeToBoolean < ActiveRecord::Migration
  def change
    remove_column :parking_spots, :type
    add_column :parking_spots, :paid, :boolean
  end
end
