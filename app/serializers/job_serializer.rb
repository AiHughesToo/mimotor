class JobSerializer < ActiveModel::Serializer
  attributes :id, :title, :note, :taken, :user_complete,
             :rider_complete, :user_id, :rider_id, :lat, 
             :long, :rider_lat, :rider_long
end
