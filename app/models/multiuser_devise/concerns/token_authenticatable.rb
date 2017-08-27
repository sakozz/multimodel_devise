module MultiuserDevise::Concerns::TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    :update_auth_token

    private :generate_authentication_token
    before_save :ensure_authentication_token
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
      self.auth_token_genenrated_at = DateTime.new
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless self.class.where(authentication_token: token).first
    end
  end

  def update_auth_token
    self.update_attributes(authentication_token: generate_authentication_token, auth_token_genenrated_at: DateTime.new)
  end
end