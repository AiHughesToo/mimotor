class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :note
      t.boolean :taken
      t.boolean :user_complete
      t.boolean :rider_complete
      t.string :type
      t.integer :user_id
      t.integer :rider_id
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
