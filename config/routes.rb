Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about', as:'about'
  get '/search' , to: 'searches#search'
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]


  resources:books,only:[:new, :create, :index, :show, :destroy, :edit, :update] do
    resources:book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

  # ネストさせる
  resources:users,only:[:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'relationships/followers' => 'relationships#followers', as: 'followers'
    get 'relationships/followings' => 'relationships#followings', as: 'followings'
  end

end
