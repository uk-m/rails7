Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  
  root "questions#index"
  resources :users, only: %i(new create show edit update)
  resources :questions do
    resources :answers
  end
end
