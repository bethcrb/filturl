Filturl::Application.routes.draw do
  authenticated :user do
    root :to => 'webpage_requests#index', as: :authenticated_root
  end

  unauthenticated do
    root :to => 'home#index'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: :registrations }
  resources :users

  get '/:id', to: 'webpage_requests#show', as: 'webpage_request'
  resources :webpage_requests, :only => [:index, :create]
end
