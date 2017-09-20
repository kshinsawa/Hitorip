Rails.application.routes.draw do

  post '/:id/posts_alternation' => 'user#alternation'
  get '/:id/posts_alternation' => 'user#user_post'

  post '/logout' => 'user#logout'
  post '/user/login' => 'user#login'
  get '/user/login_form' => 'user#login_form'
  resources :user

#コメント削除のルーティング
  post 'comment/:id' => 'comment#destroy'

  get 'home/top' => 'home#top'
  get 'home/about' => 'home#about'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  get 'posts/:id' => 'posts#show'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'

end
