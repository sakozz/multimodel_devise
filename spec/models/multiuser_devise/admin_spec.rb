require 'rails_helper'

module MultiuserDevise
  RSpec.describe Admin, type: :model do
    it { should have_one(:auth_token).class_name('MultiuserDevise::AuthToken')}
  end
end
