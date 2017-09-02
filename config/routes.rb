MultiuserDevise::Engine.routes.draw do
  devise_for :admins, class_name: "MultiuserDevise::Admin", module: :devise,
             controllers: {
                 sessions: 'multiuser_devise/admins/sessions',
                 passwords: 'multiuser_devise/admins/passwords',
                 confirmations: 'multiuser_devise/admins/confirmations',
                 registrations: 'multiuser_devise/admins/registrations'
             }, defaults: {format: :json}

  devise_for :users, class_name: "MultiuserDevise::User", module: :devise,
             controllers: {
                 sessions: 'multiuser_devise/users/sessions',
                 passwords: 'multiuser_devise/users/passwords',
                 registrations: 'multiuser_devise/users/registrations',
             }, defaults: {format: :json}
end
