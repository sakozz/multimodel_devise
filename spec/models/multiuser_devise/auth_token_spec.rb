require 'rails_helper'

module MultimodelDevise
  RSpec.describe AuthToken, type: :model do
    it { should have_db_column(:authentication_token) }
    it { should validate_presence_of :authentication_token }
    it { should validate_presence_of :token_generated_at }
    it { should belong_to(:token_authenticable)}
  end
end
