Filturl::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root :to => redirect('/users/sign_in')
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  resources :webpage_requests, :only => [:show, :create]
end
