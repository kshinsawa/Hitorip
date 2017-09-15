Rails.application.routes.draw do

  get 'user/login_form' => 'user#login_form'
  get 'user/:id' => 'user#show'
  post 'user/logout' => 'user#logout'
  post 'user/:id/login' => 'user#login'
  resources :user

#コメント削除のルーティング
  post 'comment/:id' => 'comment#destroy'
  get 'home/top' => 'home#top'
  get 'home/about' => 'home#about'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id' => 'posts#show'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

end
