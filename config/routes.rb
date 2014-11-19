Notifier::Application.routes.draw do

  root 'static_pages#home'

  match '/users/new', to: 'users#new', via: 'post'
  match '/signup', to: 'users#login', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'

  match '/sites', to: 'sites#index', via: 'get'
  match '/sites/:user_id', to: 'sites#show', via: 'get'
  match '/sites', to: 'sites#create', via: 'post'
  match '/sites/:id', to: 'sites#destroy', via: 'delete'

  #resource :sites, except: [:new, :edit]

  resource :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example site route (maps HTTP verbs to controller actions automatically):
  #   sites :products

  # Example site route with options:
  #   sites :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example site route with sub-sites:
  #   sites :products do
  #     sites :comments, :sales
  #     site :seller
  #   end

  # Example site route with more complex sub-sites:
  #   sites :products do
  #     sites :comments
  #     sites :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example site route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   sites :posts, concerns: :toggleable
  #   sites :photos, concerns: :toggleable

  # Example site route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     sites :products
  #   end
end
