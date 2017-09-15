Rails.application.routes.draw do

  post '/logout' => 'user#logout'
  post '/login' => 'user#login'
  get 'user/login_form' => 'user#login_form'
  get 'user/home' => 'user#home'
  resources :user

#コメント削除のルーティング
  post 'comment/:id' => 'comment#destroy'
  get 'home/top' => 'home#top'
  get 'home/about' => 'home#about'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  post 'posts/:id/destroy' => 'posts#destroy'

end
