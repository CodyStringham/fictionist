Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  devise_for :users,
              :controllers => { omniauth_callbacks: 'omniauth_callbacks' },
              path: '',
              path_names: {
                sign_in: 'sign-in',
                sign_up: 'sign-up',
                sign_out: 'sign-out',
                password: 'password',
              }
  resources :users

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  root to: 'visitors#sign_in'
  get '/welcome', to: 'visitors#index', as: :welcome

  post '/new-user', to: 'users#invite_new_user', as: :invite_blah
end
