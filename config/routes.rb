Rails.application.routes.draw do
  mount Knock::Engine => "/knock"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#index'
  
  
  
  
  get 'places/nearby' =>'places#nearby'
  
  resources :keys
  resources :users #, defaults: {format: :json}
  resources :places, defaults: {format: :json}
  resources :comments, defaults: {format: :json}
  resources :tags, defaults: {format: :json}
  
  
  
  
  
  get      'admin' => 'admins#index', as: :admin             #för admin
  delete   'admin' => 'key#destroy'
   
   post    'login'  => 'users#login',  as: :login
   get     'logout' => 'users#logout', as: :logout
   
end
