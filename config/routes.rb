RaspberryCook::Application.routes.draw do
  
  get "errors/not_found"
  get "errors/internal_server_error"

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  

  resources :comments

  get "pages/credits"

  get "pages/home"
  get "pages/infos"

  post "ingredients/search"

  get "recipes/index"
  get "recipes/save"
  get "recipes/search"
  match 'recipes/vote' , :to => 'recipes#vote', :via => [:get]


  get "sessions/new"

  get "users/new"
  get "users/index"
  get "users/edit"

  match '/signup' , :to => 'users#new', :via => [:get, :post]

  match '/home' ,   :to => 'pages#home', :via => [:get, :post]
  match '/infos' ,  :to => 'pages#infos', :via => [:get, :post]
  match '/credits' ,  :to => 'pages#credits', :via => :get

  match 'recipes/save/:id' ,   :to => 'recipes#save', :via => [:get, :post]

	
	match '/signin' , :to => 'sessions#new', :via => [:get, :post]
	match '/signout' ,:to => 'sessions#destroy', :via => [:get, :post]


  resources :users

  resources :recipes do 
    get :autocomplete_ingredient_name, :on => :collection
  end

  resources :ingredients, :only => [:index , :search ]
  resources :sessions, :only => [:new , :create , :destroy ]



  root :to => 'pages#home'

end
