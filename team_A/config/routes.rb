Rails.application.routes.draw do
#コメント削除のルーティング
  post 'comment/:id' => 'comment#destroy'

#ログイン後のユーザトップページ
  get 'user/:id' => 'user#top'

#ログインのルーティング
  post 'user/:id/login' => 'user#login'
  get 'user/login_form' => 'user#login_form'

#編集ページのルーティング
  post 'user/:id/edit' => 'user#update'
  get 'user/:id/edit' => 'user#edit'

#新規投稿ページのルーティング
  get 'user/new' => 'user#new'
  post 'user/new' => 'user#create'

#トップページのルーティング
  get 'user/home' => 'user#home'
  root 'home#home'

end
