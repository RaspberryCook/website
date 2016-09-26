RaspberryCook::Application.routes.draw do

  resources :users
  match '/signup' , :to => 'users#new', :via => [:get, :post]

  resources :recipes, :only => [:index, :new , :show, :create , :destroy , :edit]
  match 'recipes/save/:id' ,   :to => 'recipes#save', :via => [:get, :post]
  match 'recipes/search' ,   :to => 'recipes#search', :via => :get
  match 'recipes/fork/:id' ,   :to => 'recipes#fork', :via => :get
  match 'recipes/fork' ,   :to => 'recipes#fork', :via => :post
  match 'recipes/vote' , :to => 'recipes#vote', :via => :get

  resources :sessions, :only => [:new , :create , :destroy ]
  match '/signin' , :to => 'sessions#new', :via => [:get, :post]
  match '/signout' ,:to => 'sessions#destroy', :via => [:get, :post]
  
  get "errors/not_found"
  get "errors/internal_server_error"
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  get "pages/credits"
  get "pages/home"
  get "pages/infos"
  match '/home' ,   :to => 'pages#home', :via => [:get, :post]
  match '/infos' ,  :to => 'pages#infos', :via => [:get, :post]
  match '/credits' ,  :to => 'pages#credits', :via => :get

  root :to => 'pages#home'

end
