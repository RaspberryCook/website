RaspberryCook::Application.routes.draw do
  


  

  resources :comments

  get "pages/credits"

  get "pages/home"
  get "pages/infos"

  post "ingredients/search"

  get "recipes/index"
  get "recipes/save"
  get "recipes/search"

  get "sessions/new"

  get "users/new"
  get "users/index"
  get "users/edit"

  match '/signup' , :to => 'users#new', :via => [:get, :post]

  match '/home' ,   :to => 'pages#home', :via => [:get, :post]
  match '/infos' ,  :to => 'pages#infos', :via => [:get, :post]
  match '/credits' ,  :to => 'pages#credits', :via => :get

  match 'recipes/save' ,   :to => 'recipes#save', :via => [:get, :post]

	
	match '/signin' , :to => 'sessions#new', :via => [:get, :post]
	match '/signout' ,:to => 'sessions#destroy', :via => [:get, :post]


  resources :users

  resources :recipes do 
    get :autocomplete_ingredient_name, :on => :collection
  end

  resources :ingredients, :only => [:index , :search ]
  resources :sessions, :only => [:new , :create , :destroy ]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
