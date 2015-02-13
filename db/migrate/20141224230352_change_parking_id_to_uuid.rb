class ChangeParkingIdToUuid < ActiveRecord::Migration
  def change
    # Recreate the table with the new primary key, mainly for
    # the vain reason of wanting id to be the first column
    create_table :parking_spots_new, id: :uuid do |t|
      t.string :name
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.text :description
      t.boolean :paid, :default => true
      t.integer :spaces
      t.boolean :deleted, :default => false
      t.timestamps default: 'NOW()', null: true # I am not sure why I used the default option >_>. I have undone it in a later migration.
      t.integer :created_by_id
      t.integer :updated_by_id
    end
    cols = "name, latitude, longitude, description, paid, spaces, deleted, created_at, updated_at, created_by_id, updated_by_id"
    reversible do
      ActiveRecord::Base.connection.execute("INSERT INTO parking_spots_new (#{cols}) SELECT #{cols} FROM parking_spots;")
    end
    rename_table :parking_spots, :parking_spots_old
    rename_table :parking_spots_new, :parking_spots
  end
end
