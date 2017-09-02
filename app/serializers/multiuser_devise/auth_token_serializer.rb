module MultiuserDevise
  class AuthTokenSerializer < ActiveModel::Serializer
    attributes :identifier, :authentication_token
    def identifier
      self.object.id
    end
  end
end
