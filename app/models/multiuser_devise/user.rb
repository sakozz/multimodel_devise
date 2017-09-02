module MultiuserDevise
  class User < ApplicationRecord
    include Concerns::TokenAuthenticatable

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_one :auth_token, as: :token_authenticable, dependent: :destroy,
            class_name: 'MultiuserDevise::AuthToken'

    accepts_nested_attributes_for :auth_token, reject_if: proc {
        |attributes| attributes['authentication_token'].blank? || attributes['token_authenticable_type'].blank?
    }
  end
end
