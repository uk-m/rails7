Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root "questions#index"
  resources :users do
    collection do
      get :search
    end
    member do
      get :following, :followers, :interest, :like, :question
    end
  end
  resources :categories, only: %i(index show)
  resources :relationships, only: %i(create destroy)
  resources :questions do
    collection do
      get :search
    end
    resources :interests, only: %i(create destroy)
    resources :answers, only: %i(create destroy) do
      resources :likes, only: %i(create destroy)
    end
  end
end
