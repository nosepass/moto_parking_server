class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :device_id
      t.string :model
      t.string :build_json

      t.timestamps
    end
  end
end
