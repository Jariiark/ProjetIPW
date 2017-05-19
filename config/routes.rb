Rails.application.routes.draw do
  get 'sessions/new'
  resources :feeds
  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :feeds, :only => [:create, :destroy, :edit]
  #get 'pages/home'
  #get 'pages/sessions'
  #get 'pages/contact'
  get 'users/new'
  get '/signup' => 'users#new'
  get '/contact' => 'pages#contact'
  get '/about' => 'pages#about'
  get '/help' => 'pages#help'
  root :to => 'pages#home'
  get 'feeds/index' => 'feeds#index'
  
  post '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
