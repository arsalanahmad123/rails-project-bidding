Rails.application.routes.draw do
  require("sidekiq/web")
  root 'pages#index'
  get 'users/signup',to: "users#new",as: 'new_signup'
  post 'users/signup',to: "users#create",as: 'signup'
  get "users/login",to: "sessions#new",as: 'login'
  post "users/login",to: "sessions#create",as: 'create_session'
  delete "users/logout",to: "sessions#destroy",as: 'destroy_session'
  get "users/:id",to: "users#show",as: 'user'
  resources :projects do 
    resources :bids,only: [:new,:create]
  end

    mount Sidekiq::Web => '/sidekiq'
  post "/deleteAllExpiredBids",to: "projects#destroy_expired_bids",as: 'delete_all_expired_bids'

  match '*path', to: 'errors#not_found', via: :all
end
