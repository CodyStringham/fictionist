Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  devise_for :users,
              path: '',
              path_names: {
                sign_in: 'sign-in',
                sign_up: 'sign-up',
                sign_out: 'sign-out',
                password: 'password',
              }
  resources :users

  root to: 'visitors#index'
end
