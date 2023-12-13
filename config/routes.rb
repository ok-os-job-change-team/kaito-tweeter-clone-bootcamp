Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :tweets, only: [:index, :show, :new, :create]
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
