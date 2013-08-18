Hearus::Application.routes.draw do
  # get  'district/find', to: 'district#new', as: :find_district
  # post 'district/find', to: 'district#create', as: :set_district

  resources :users
  resources :districts do
    collection do
      get  :find
      post :set
    end
  end

  # /district/WHATEVER
  # /district/123/bomb
  resources :sessions

  get '/about', to: 'landing#about', as: 'about'
  root :to => 'landing#show'
end
