class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image_link, :account_type
  has_many :jobs
  has_one :stat
end
