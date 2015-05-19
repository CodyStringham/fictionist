Rails.application.routes.draw do

  devise_for :users,
              controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: "users/registrations" },
              path: '',
              path_names: {
                sign_in: 'sign-in',
                sign_up: 'sign-up',
                sign_out: 'sign-out',
                password: 'password',
              }

  resources :users, except: [:new, :create]

  post '/users/:id/update_points', to: 'users#update_points', as: :update_points
  post '/new-user', to: 'users#invite_new_user', as: :invite
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], as: :finish_signup

  # points
  resources :points, only: [:index]
  get '/points/:effort_id/new', to: 'points#new', as: :new_point
  post '/points/:effort_id', to: 'points#create', as: :create_point

  get '/share-location', to: 'points#share_location', as: :share_location
  post '/share-location', to: 'points#create_share_location', as: :create_share_location

  get '/request-venue', to: 'points#request_venue', as: :request_venue

  get '/uploads/:id', to: 'contents#show', as: :content

  get '/uploads/:id/purchase', to: 'contents#purchase', as: :purchase_content
  post '/uploads/:id/purchase', to: 'contents#redeem_points', as: :redemptions

  # admin
  authenticated :user, lambda {|u| u.admin? || u.band_member? } do
    mount Upmin::Engine => '/admin'

    # uploads
    resources :contents, except: :show

    # efforts
    resources :efforts, except: [:show, :new, :create, :destroy]
    get '/efforts/award', to: 'efforts#award', as: :award
    post '/efforts/award/approved/:user_id/:user_effort', to: 'efforts#approve', as: :approve_effort
    post '/efforts/award/declined/:user_id/:user_effort', to: 'efforts#decline', as: :decline_effort
  end

  root to: 'visitors#index'

end

# == Route Map
#
#                   Prefix Verb      URI Pattern                        Controller#Action
#                    upmin           /admin                             Upmin::Engine
#         new_user_session GET       /sign-in(.:format)                 devise/sessions#new
#             user_session POST      /sign-in(.:format)                 devise/sessions#create
#     destroy_user_session DELETE    /sign-out(.:format)                devise/sessions#destroy
#  user_omniauth_authorize GET|POST  /auth/:provider(.:format)          omniauth_callbacks#passthru {provider: /facebook|twitter/}
#   user_omniauth_callback GET|POST  /auth/:action/callback(.:format)   omniauth_callbacks#:action
#            user_password POST      /password(.:format)                devise/passwords#create
#        new_user_password GET       /password/new(.:format)            devise/passwords#new
#       edit_user_password GET       /password/edit(.:format)           devise/passwords#edit
#                          PATCH     /password(.:format)                devise/passwords#update
#                          PUT       /password(.:format)                devise/passwords#update
# cancel_user_registration GET       /cancel(.:format)                  devise_invitable/registrations#cancel
#        user_registration POST      /                                  devise_invitable/registrations#create
#    new_user_registration GET       /sign-up(.:format)                 devise_invitable/registrations#new
#   edit_user_registration GET       /edit(.:format)                    devise_invitable/registrations#edit
#                          PATCH     /                                  devise_invitable/registrations#update
#                          PUT       /                                  devise_invitable/registrations#update
#                          DELETE    /                                  devise_invitable/registrations#destroy
#        user_confirmation POST      /confirmation(.:format)            devise/confirmations#create
#    new_user_confirmation GET       /confirmation/new(.:format)        devise/confirmations#new
#                          GET       /confirmation(.:format)            devise/confirmations#show
#   accept_user_invitation GET       /invitation/accept(.:format)       devise/invitations#edit
#   remove_user_invitation GET       /invitation/remove(.:format)       devise/invitations#destroy
#          user_invitation POST      /invitation(.:format)              devise/invitations#create
#      new_user_invitation GET       /invitation/new(.:format)          devise/invitations#new
#                          PATCH     /invitation(.:format)              devise/invitations#update
#                          PUT       /invitation(.:format)              devise/invitations#update
#                    users GET       /users(.:format)                   users#index
#                          POST      /users(.:format)                   users#create
#                 new_user GET       /users/new(.:format)               users#new
#                edit_user GET       /users/:id/edit(.:format)          users#edit
#                     user GET       /users/:id(.:format)               users#show
#                          PATCH     /users/:id(.:format)               users#update
#                          PUT       /users/:id(.:format)               users#update
#                          DELETE    /users/:id(.:format)               users#destroy
#            finish_signup GET|PATCH /users/:id/finish_signup(.:format) users#finish_signup
#                     root GET       /                                  visitors#sign_in
#                  welcome GET       /welcome(.:format)                 visitors#index
#              invite_blah POST      /new-user(.:format)                users#invite_new_user
#                     page GET       /pages/*id                         high_voltage/pages#show
#
# Routes for Upmin::Engine:
#               root GET      /                                 upmin/models#dashboard
#    upmin_dashboard GET      /                                 upmin/models#dashboard
#       upmin_search GET|POST /m/:klass(.:format)               upmin/models#search
#    upmin_new_model GET      /m/:klass/new(.:format)           upmin/models#new
# upmin_create_model POST     /m/:klass/new(.:format)           upmin/models#create
#        upmin_model GET      /m/:klass/i/:id(.:format)         upmin/models#show
#                    PUT      /m/:klass/i/:id(.:format)         upmin/models#update
#       upmin_action POST     /m/:klass/i/:id/:method(.:format) upmin/models#action
#
