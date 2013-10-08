Filturl::Application.routes.draw do
  root :to => 'webpage_requests#index'

  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/devise/registrations',
    sessions:           'users/devise/sessions',
  }
  resources :users

  get '/urls/:id', to: 'webpages#show', as: 'webpage'
  post '/urls/request', to: 'webpage_requests#create', as: 'webpage_requests'
end
