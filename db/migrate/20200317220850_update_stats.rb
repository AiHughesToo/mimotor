class UpdateStats < ActiveRecord::Migration[5.1]
  def change
    change_column :stats, :life_t_distance, :float
    change_column :stats, :daily_distance, :float
  end
end
