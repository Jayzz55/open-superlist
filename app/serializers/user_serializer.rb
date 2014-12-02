class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :auth_token
end
