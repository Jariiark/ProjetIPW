Rails.application.routes.draw do
  resources :feeds do
  member do
   resources :entries, only: [:index, :show]
  end
end

  get 'sessions/new'
  #resources :feeds
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
  
  get 'entries/index' =>'entrie#index'
  get 'entries/show' =>'entrie#show'
  get 'feeds/index' => 'feeds#index'
  get 'feeds/edit' => 'feeds#edit'
  get 'feeds/destroy' => 'feeds#destroy'
  post '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
