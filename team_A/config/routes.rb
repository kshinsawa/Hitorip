Rails.application.routes.draw do

  post '/bookmark/:id/destroy' => 'bookmark#destroy'

  post '/logout' => 'user#logout'
  post '/user/login' => 'user#login'
  get '/user/login_form' => 'user#login_form'
  resources :user

  # コメント作成
  post 'comment/:id/create' => 'comment#create'
  # コメント削除
  post 'comment/:id/destroy' => 'comment#destroy'

  # トップページ
  get 'home/top' => 'home#top'
  # 紹介ページ
  get 'home/about' => 'home#about'

  # ブックマーク登録
  post 'posts/:id/bookmark' => 'posts#bookmark'
  # 評価
  post 'posts/:id/evaluation' => 'posts#evaluation'
  # 投稿一覧表示
  get 'posts/index' => 'posts#index'
  # 新規投稿ページ
  get 'posts/new' => 'posts#new'
  # 新規投稿作成
  post 'posts/create' => 'posts#create'
  # 投稿編集ページ
  get 'posts/:id/edit' => 'posts#edit'
  # 投稿詳細ページ
  get 'posts/:id' => 'posts#show'
  # 投稿編集
  post 'posts/:id/update' => 'posts#update'
  # 投稿削除
  post 'posts/:id/destroy' => 'posts#destroy'

end
