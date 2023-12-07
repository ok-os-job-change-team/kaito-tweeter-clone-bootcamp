Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update]
<<<<<<< HEAD
  resources :tweets, only: [:index, :show]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
=======
  resources :tweets, only: [:index, :show, :new, :create]
>>>>>>> 6c8875d (Tweetコントローラのnew,createアクションを実装)
end
