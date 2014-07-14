Rails.application.routes.draw do
  root 'webpage_requests#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/devise/registrations',
    sessions:           'users/devise/sessions'
  }
  resources :users

  match '(errors)/:status', constraints: { status: /\d{3}/ },
                            to:          'errors#show',
                            via:         :all

  get '/robots.txt', to: 'robots#show'

  post '/',          to: 'webpage_requests#create', as: 'webpage_requests'

  get '/urls/:id', to: 'webpage_requests#show',
                   as: 'webpage_request',
                   id: /https?-.{3,255}/
end
