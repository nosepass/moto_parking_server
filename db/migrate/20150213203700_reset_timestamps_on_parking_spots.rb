class ResetTimestampsOnParkingSpots < ActiveRecord::Migration
  def change
    change_column :parking_spots, :created_at, :datetime, :null => true, :default => nil
    change_column :parking_spots, :updated_at, :datetime, :null => true, :default => nil
  end
end
