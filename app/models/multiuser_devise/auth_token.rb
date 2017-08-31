module MultiuserDevise
  class AuthToken < ApplicationRecord
    belongs_to :token_authenticable, polymorphic: true
    validates_presence_of :authentication_token, :token_generated_at
  end
end
