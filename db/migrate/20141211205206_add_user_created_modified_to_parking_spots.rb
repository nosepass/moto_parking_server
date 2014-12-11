class AddUserCreatedModifiedToParkingSpots < ActiveRecord::Migration
  def change
    add_column :parking_spots, :created_by_id, :integer
    add_column :parking_spots, :updated_by_id, :integer
  end
end
