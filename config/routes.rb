Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  root "questions#index"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :categories, only: %i(index show)
  resources :relationships, only: %i(create destroy)
  resources :questions do
    resources :answers, only: %i(create destroy)
  end
end
