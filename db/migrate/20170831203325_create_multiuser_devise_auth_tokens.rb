class CreateMultiuserDeviseAuthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :multiuser_devise_auth_tokens do |t|
      t.references :token_authenticable, polymorphic: true, index: {name: "index_multiuser_devise_auth_token_model_type"}
      t.string :authentication_token, index: {name: "index_multiuser_devise_auth_token", unique: true}
      t.datetime :token_generated_at
      t.timestamps
    end
  end
end
