module MultiuserDevise::Concerns::TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    :update_auth_token

    private :generate_authentication_token
    before_save :ensure_authentication_token
  end

  def ensure_authentication_token
    if auth_token.blank?
      self.auth_token = ::MultiuserDevise::AuthToken.new(
          authentication_token: generate_authentication_token,
          token_generated_at: DateTime.new,
          token_authenticable: self
      )
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless ::MultiuserDevise::AuthToken.where(authentication_token: token).first
    end
  end

  def update_auth_token
    self.auth_token.update_attributes(
        authentication_token: generate_authentication_token,
        token_generated_at: DateTime.new
    )
  end
end