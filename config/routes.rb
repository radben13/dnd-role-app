Rails.application.routes.draw do
  
  resources :players, :param => :player_id
  
  resources :roles, only: [:show, :edit, :update, :destroy] do
    resources :attr_sets
  end
  
  get "players/:player_id/new_role", :to => "roles#new", :as => :new_role
  post "players/:player_id/create_role", :to => "roles#create", :as => :create_role
  post "roles/:id/edit", :to => "roles#update", :as => :update_role
  
  resources :items
  
  get "admin/test", :to => "pages#dnd_test"
  get "api/roles/types", :to => "roles#get_role_types"
  post "login", :to => "user_sessions#new"
  get "login", :to => "user_sessions#login", :as => :login_path
  get "logout", :to => "user_sessions#logout", :as => :logout
  
  root 'pages#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
