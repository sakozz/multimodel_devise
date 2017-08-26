require 'rails_helper'

module MultiuserDevise
  RSpec.describe User, type: :model do
      it { should have_db_column(:token).fail('Column name token does not exist') }
  end
end
