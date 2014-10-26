Hfunding::Application.routes.draw do
 
  #get "campaigns/index"
  #get "donations/index"
  #get "users/index"
  #get "welcome/index"

  root 'welcome#index'

  resources :users do
      get :charge, only: [:show]
  end

  resources :costs

  match '/signup',    to: 'users#new',          via: 'get'
  match '/charge',    to: 'users#update_money',          via: 'post'

  resources :campaigns do   #definisce un' azione sulla route campaigns/mine
    get :mine, :on => :collection
    resources :donations, only: [:new, :create]
    resources :costs, only: [:new, :create]
  end

  match '/discover',   to: 'campaigns#discover',    via: 'get'

  resources :donations do
    get :mine, :on => :collection
  end

  match '/donate',  to: 'donations#new',         via: 'get'

  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'post'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signout', to: 'sessions#destroy',     via: 'post'
  match '/signout', to: 'sessions#destroy',     via: 'get'
  

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
