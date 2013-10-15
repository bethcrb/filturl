Filturl::Application.routes.draw do
  root :to => 'webpage_requests#index'

  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/devise/registrations',
    sessions:           'users/devise/sessions',
  }
  resources :users

  get '/robots.txt', to: 'webpage_requests#robots'
  post '/',          to: 'webpage_requests#create', as: 'webpage_requests'
  get '/urls/:id',   to: 'webpages#show',           as: 'webpage'
end
