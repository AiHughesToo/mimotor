class RenameLatAndLongInJobs < ActiveRecord::Migration[5.1]
  def change
    rename_column :jobs, :lat, :latitude
    rename_column :jobs, :long, :longitude
  end
end
