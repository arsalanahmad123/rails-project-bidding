Rails.application.routes.draw do
  root 'pages#index'
  get 'users/signup',to: "users#new",as: 'new_signup'
  post 'users/signup',to: "users#create",as: 'signup'
  get "users/login",to: "sessions#new",as: 'login'
  post "users/login",to: "sessions#create",as: 'create_session'
  delete "users/logout",to: "sessions#destroy",as: 'destroy_session'
  resources :projects
end
