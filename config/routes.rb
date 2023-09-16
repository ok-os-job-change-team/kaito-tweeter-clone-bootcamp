Rails.application.routes.draw do
  get 'index' => 'users#index'
  get 'show' => 'users#show'
end
