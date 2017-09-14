Rails.application.routes.draw do
  get 'home/top' => 'home#top'
  get 'home/about' => 'home#about'

  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  post 'posts/:id/destroy' => 'posts#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
