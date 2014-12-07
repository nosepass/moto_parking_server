class ChangeBuildJsonLength < ActiveRecord::Migration
  def change
    change_column :phones, :build_json, :text
  end
end
