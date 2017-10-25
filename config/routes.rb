RaspberryCook::Application.routes.draw do

  resources :comments, :only => [:new , :create , :update, :destroy , :edit]

  resources :users
  match '/signup' , to: 'users#new', :via => [:get, :post]

  resources :recipes, :only => [:show, :index, :new , :create , :destroy , :edit, :update]
  match 'recipes/:id/fork', as: 'fork_recipe', to: 'recipes#fork', id: /[0-9]+/, via: [:get, :post]
  get 'shuffle', to: 'recipes#shuffle', as: 'recipes_shuffle'
  get 'recipes/:id/save', as: 'save_recipe', to: 'recipes#save', id: /[0-9]+/

  resources :sessions, :only => [:new , :create , :destroy ]
  match '/signin' , to: 'sessions#new', :via => [:get, :post]
  match '/signout' ,to: 'sessions#destroy', :via => [:get, :post]

  match "/404", to: "errors#not_found", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all

  match '/fridge' ,   to: 'pages#fridge', as: 'fridge', :via => :all

  get '/home', to: 'pages#home', as: 'home'
  get '/legal', to: 'pages#legal', as: 'legal'
  get '/about', to: 'pages#about', as: 'about'
  get '/feeds', to: 'pages#feeds', as: 'feeds'
  get '/infos', to: 'pages#infos', as: 'infos'
  get '/credits', to: 'pages#credits', as: 'credits'

  root to: 'pages#home'

end
