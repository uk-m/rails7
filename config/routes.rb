Rails.application.routes.draw do
  get 'categories/index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
  root "questions#index"
  resources :users
  resources :questions do
    resources :answers, only: %i(create destroy)
  end
end
