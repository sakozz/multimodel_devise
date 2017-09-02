module MultiuserDevise
  class SessionSerializer < ActiveModel::Serializer
    attributes :id, :email
    has_one :auth_token
  end
end
