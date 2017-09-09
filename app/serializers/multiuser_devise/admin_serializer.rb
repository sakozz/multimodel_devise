module MultiuserDevise
  class AdminSerializer < ActiveModel::Serializer
    attributes :id, :email
  end
end
