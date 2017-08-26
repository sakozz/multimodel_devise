MultiuserDevise::Engine.routes.draw do
  devise_for :users, class_name: "MultiuserDevise::User", module: :devise,
              controllers: {
              	sessions:      'multiuser_devise/users/sessions',
              	passwords:     'multiuser_devise/users/passwords',
              	registrations: 'multiuser_devise/users/registrations',
              	confirmations: 'multiuser_devise/users/confirmations',
              	:invitations => 'multiuser_devise/users/invitations'
              }, defaults: { format: :json }
end
