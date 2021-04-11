Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :books, only: [:create, :index, :show, :destroy, :update,:edit] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :index, :show, :destroy, :update,:edit] do
    resource :relationships, only: [:create, :destroy]
    get 'follower_user' => 'relationships#follower_user', as: 'follower_user'
    get 'following_user' => 'relationships#following_user', as: 'following_user'
  end

end
