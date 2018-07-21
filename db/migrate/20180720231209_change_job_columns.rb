class ChangeJobColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :rider_lat, :float
    add_column :jobs, :rider_long, :float
    remove_column :jobs, :type
  end
end
