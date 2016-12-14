RaspberryCook::Application.routes.draw do

  resources :comments, :only => [:new , :create , :update, :destroy , :edit]

  resources :users
  match '/signup' , to: 'users#new', :via => [:get, :post]

  resources :recipes, :only => [:index, :new , :create , :destroy , :edit]
  get     'recipes/:id' ,         to: 'recipes#show', id: /[0-9]+/
  patch  'recipes/:id' ,         to: 'recipes#update', id: /[0-9]+/
  get     'recipes/fork/:id' ,  to: 'recipes#fork'
  post    'recipes/fork' ,      to: 'recipes#fork'
  get    'recipes/shuffle' ,      to: 'recipes#shuffle'
  get     'recipes/save/:id' , to: 'recipes#save', as: 'recipe_save'
  get     'recipes/vote/:id' ,  to: 'recipes#vote'

  resources :sessions, :only => [:new , :create , :destroy ]
  match '/signin' , to: 'sessions#new', :via => [:get, :post]
  match '/signout' ,to: 'sessions#destroy', :via => [:get, :post]
  
  match "/404", to: "errors#not_found", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all
  
  match '/fridge' ,   to: 'pages#fridge', as: 'fridge', :via => :all

  get '/home' ,   to: 'pages#home', as: 'home'
  get '/feeds' ,   to: 'pages#feeds', as: 'feeds'
  get '/infos' ,  to: 'pages#infos', as: 'infos'
  get '/credits' ,  to: 'pages#credits', as: 'credits'

  root to: 'pages#home'

end
