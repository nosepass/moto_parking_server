class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :fname
      t.string :lname
      t.string :email
      t.string :epassword
      t.string :salt

      t.timestamps
    end
  end
end
