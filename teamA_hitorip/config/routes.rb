Rails.application.routes.draw do

  post 'user/logout' => 'user#logout'
  post 'user/:id/login' => 'user#login'
  get 'user/login_form' => 'user#login_form'
  get 'user/home' => 'user#home'
  resources :user

end
