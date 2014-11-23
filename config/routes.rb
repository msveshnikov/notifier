Notifier::Application.routes.draw do

  resources :users
  root 'sites#index'

  #match '/users/new', to: 'users#new', via: 'post'
  match '/signup', to: 'users#login', via: 'get'

  #match '/sites', to: 'sites#index', via: 'get'
  #match '/sites/:user_id', to: 'sites#show', via: 'get'
  #match '/sites', to: 'sites#create', via: 'post'
  #match '/sites/:id', to: 'sites#destroy', via: 'delete'

  resources :sites, except: [:new, :edit]


end
