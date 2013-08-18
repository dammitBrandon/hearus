Hearus::Application.routes.draw do
  resources :users
  resources :district

  get  'district/find', to: 'district#new', as: :find_district
  post 'district/find', to: 'district#create', as: :set_district

  root :to => 'landing#index'
end
