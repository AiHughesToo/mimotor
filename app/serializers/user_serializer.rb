class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image_link, :account_type, :reset_password_token, :vin_number, :plate_number, :bike_type
  has_many :jobs
  has_one :stat
end
