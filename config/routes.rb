Rails.application.routes.draw do
  get 'mypage', to: 'users#show'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root "questions#index"
  resources :users, only: %i(new create)
  resources :questions do
    resources :answers
  end
end
