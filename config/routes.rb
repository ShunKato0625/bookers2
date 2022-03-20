Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about', as:'about'


  resources:books,only:[:new, :create, :index, :show, :destroy, :edit, :update] do
    resources:book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end

  resources:users,only:[:index, :show, :edit, :update]

end
