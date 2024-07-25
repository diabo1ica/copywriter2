Rails.application.routes.draw do
  get 'errors/invalid_token'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'invalid_token', to: 'errors#invalid_token', as: :invalid_token

  resources :posts
  
  # Defines the root path route ("/")
  # root "posts#index"
  root "posts#index"
end

