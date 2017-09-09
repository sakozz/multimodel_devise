MultimodelDevise::Engine.routes.draw do
	devise_for :admins, class_name: "MultimodelDevise::Admin", module: :devise,
             controllers: {
                 sessions: 'multimodel_devise/admins/sessions',
                 passwords: 'multimodel_devise/admins/passwords',
                 confirmations: 'multimodel_devise/admins/confirmations',
                 registrations: 'multimodel_devise/admins/registrations'
             }, defaults: {format: :json}

             devise_for :users, class_name: "MultimodelDevise::User", module: :devise,
             controllers: {
                 sessions: 'multimodel_devise/users/sessions',
                 passwords: 'multimodel_devise/users/passwords',
                 registrations: 'multimodel_devise/users/registrations',
             }, defaults: {format: :json}

  resources :users , only: [:index, :update, :show], defaults: {format: :json}
  resources :admins , only: [:index, :update, :show], defaults: {format: :json}
end
