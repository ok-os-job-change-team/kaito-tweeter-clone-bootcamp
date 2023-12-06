Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :tweets, only: [:index, :show]
end
