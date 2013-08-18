Filturl::Application.routes.draw do
  root :to => 'webpage_requests#index'

  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/devise/registrations',
    sessions:           'users/devise/sessions',
  }
  resources :users

  get '/:id', to: 'webpage_requests#show', as: 'webpage_request'
  post '/', to: 'webpage_requests#create', as: 'webpage_requests'
end
