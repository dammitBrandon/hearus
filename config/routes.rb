Hearus::Application.routes.draw do
  resources :users
  resources :district

  get  'district/find', to: 'district#new', as: :find_district
  post 'district/find', to: 'district#create', as: :set_district

  # oauth routes
  match 'auth/:provider/callback' => 'sessions#create'
  match 'auth/failure'            => redirect('/')

  get  '/login'    => 'sessions#new', as: :login
  post '/login'    => 'sessions#create', as: :login
  get '/logout'   => 'sessions#destroy', as: :logout
  get '/register' => 'users#new', as: :user

  root :to => 'landing#index'
end
