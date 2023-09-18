Rails.application.routes.draw do
  # get 'index' => 'users#index'
  resources :users, only: [:show, :index]
end
