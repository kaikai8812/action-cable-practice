Rails.application.routes.draw do
  get 'search/search'
  get 'relationships/create'
  get 'relationships/destroy'
  get 'home/about' => 'homes#about'
  # get 'search/search'
  get '/search', to: 'search#search'

  # 新規登録、サインイン後のリダイレクト先を決めるタメのやつ
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  # 新規登録、サインイン後のリダイレクト先を決めるタメのやつ

  root to: 'homes#top'
  
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
    
  end

end
