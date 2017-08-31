module MultiuserDevise
  class Admin < ApplicationRecord
    include Concerns::TokenAuthenticatable

    # Include default devise modules. Others available are:
      # :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable,
           :confirmable, :lockable, :timeoutable
    has_one :auth_token, as: :token_authenticable, dependent: :destroy,
            class_name: 'MultiuserDevise::AuthToken'
  end
end
