Rails.application.routes.draw do
  mount MultiuserDevise::Engine => "/multiuser_devise"
end
