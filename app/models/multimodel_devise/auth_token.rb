module MultimodelDevise
  class AuthToken < ApplicationRecord
    belongs_to :token_authenticable, polymorphic: true
    validates_presence_of :authentication_token, :token_generated_at
    
    def token_valid?
      self.expiry_date > DateTime.now
    end
    
    def expiry_date
      self.token_generated_at + MultimodelDevise::Engine.config.token_expires_in
    end
  end

end
