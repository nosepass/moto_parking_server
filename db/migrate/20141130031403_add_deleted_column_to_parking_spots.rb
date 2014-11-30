class AddDeletedColumnToParkingSpots < ActiveRecord::Migration
  def change
    add_column :parking_spots, :deleted, :boolean, :default => false
  end
end
