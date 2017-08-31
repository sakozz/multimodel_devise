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
    validates_presence_of :auth_token
    accepts_nested_attributes_for :auth_token, reject_if: proc {
        |attributes| attributes['authentication_token'].blank? || attributes['token_authenticable_type'].blank?
    }
    
  end
end
