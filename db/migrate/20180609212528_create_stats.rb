class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.integer :life_t_distance
      t.integer :life_t_num_jobs
      t.integer :daily_job_num
      t.integer :daily_distance
      t.integer :user_id

      t.timestamps
    end
  end
end
