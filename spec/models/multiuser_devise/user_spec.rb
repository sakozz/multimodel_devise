require 'rails_helper'

module MultiuserDevise
  RSpec.describe User, type: :model do
    it { should have_one(:auth_token).class_name('MultiuserDevise::AuthToken')}
    # it { should validate_presence_of :auth_token }
    it { should accept_nested_attributes_for :auth_token }
  end
end
