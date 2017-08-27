MultiuserDevise::Engine.routes.draw do
  devise_for :users, class_name: "MultiuserDevise::User", module: :devise,
              controllers: {
              	sessions:      'multiuser_devise/users/sessions',
              	passwords:     'multiuser_devise/users/passwords',
              	registrations: 'multiuser_devise/users/registrations'
              }, defaults: { format: :json }
end
