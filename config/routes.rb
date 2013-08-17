Hearus::Application.routes.draw do
  resources :users
  root :to => 'landing#index'
end
