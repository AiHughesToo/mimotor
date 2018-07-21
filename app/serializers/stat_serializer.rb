class StatSerializer < ActiveModel::Serializer
  attributes :id, :life_t_distance, :life_t_num_jobs, :daily_job_num, :daily_distance, :user_id
end
