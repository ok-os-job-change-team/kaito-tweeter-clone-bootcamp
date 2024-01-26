Rails.application.routes.draw do
  resources :users, only: %i[index new create show destroy edit update]
  resources :tweets, only: %i[index new create show destroy edit update] do
    resource :favorites, only: %i[create destroy]
    get :favorite, on: :collection
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
