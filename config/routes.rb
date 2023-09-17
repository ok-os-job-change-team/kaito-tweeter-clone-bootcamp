Rails.application.routes.draw do
  get 'index' => 'users#index'
  get 'show/:id' => 'users#show'
end
