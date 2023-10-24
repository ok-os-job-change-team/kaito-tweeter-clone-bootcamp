Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update]
end
