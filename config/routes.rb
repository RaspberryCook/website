RaspberryCook::Application.routes.draw do

  resources :users
  match '/signup' , to: 'users#new', :via => [:get, :post]

  resources :recipes, :only => [:index, :new , :create , :destroy , :edit]
  match 'recipes/:id' ,  to: 'recipes#show', :via => :get
  match 'recipes/fork/:id' ,   to: 'recipes#fork', :via => :get
  match 'recipes/fork' ,   to: 'recipes#fork', :via => :post
  match 'recipes/search' ,   to: 'recipes#search', :via => :get
  match 'recipes/vote' , to: 'recipes#vote', :via => :get

  resources :sessions, :only => [:new , :create , :destroy ]
  match '/signin' , to: 'sessions#new', :via => [:get, :post]
  match '/signout' ,to: 'sessions#destroy', :via => [:get, :post]
  
  get "errors/not_found"
  get "errors/internal_server_error"
  match "/404", to: "errors#not_found", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all

  get '/home' ,   to: 'pages#home', as: 'home'
  get '/infos' ,  to: 'pages#infos', as: 'infos'
  get '/credits' ,  to: 'pages#credits', as: 'credits'

  root to: 'pages#home'

end
