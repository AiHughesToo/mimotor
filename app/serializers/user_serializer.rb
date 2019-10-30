class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image_link, :account_type, :reset_password_token
  has_many :jobs
  has_one :stat
end
