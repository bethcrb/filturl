Filturl::Application.routes.draw do
  get "users/index"
  get "users/show"
  authenticated :user do
    root :to => 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root :to => 'home#index'
  end

  devise_for :users
  resources :users
end
