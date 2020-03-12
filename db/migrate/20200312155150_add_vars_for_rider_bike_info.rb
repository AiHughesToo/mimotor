class AddVarsForRiderBikeInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :vin_number, :string
    add_column :users, :plate_number, :string
    add_column :users, :bike_type, :string
  end
end
