Rails.application.routes.draw do
  mount_devise_token_auth_for 'Account', at: 'auth'

  resources :offers, only: %i[create destroy]
end
