module MultiuserDevise
  class AdminSerializer < ActiveModel::Serializer
    attributes :id, :email, :authentication_token
  end
end
