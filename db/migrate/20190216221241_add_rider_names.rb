class AddRiderNames < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :rider_name, :string
  end
end
