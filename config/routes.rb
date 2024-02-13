Rails.application.routes.draw do
  resources :users, only: %i[index new create show destroy edit update] do
    member do
      get :favorites
    end
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :tweets, only: %i[index new create show destroy edit update] do
    resource :favorites, only: %i[create destroy]
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '*path', controller: 'application', action: 'render_404'
end
