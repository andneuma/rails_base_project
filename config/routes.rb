Rails.application.routes.draw do
	root to: 'application#landing'

  # ReactOnRails sample route
  get 'hello_world', to: 'hello_world#index'

  # SESSION
  get '/logout', to: 'sessions#destroy'
	get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  # USER
  get '/sign_up', to: 'users#new', as: :sign_up
  post '/sign_up', to: 'users#create'

  resources :users, only: [:edit, :update]
	delete '/users/:id', to: 'users#destroy', as: :destroy_user


  # Password reset
  get '/request_password_reset/new', to: 'password_reset#request_password_reset', as: :request_password_reset
  post '/request_password_reset', to: 'password_reset#create_password_reset'
  get '/reset_password/:token', to: 'password_reset#reset_password', as: :reset_password
  patch '/reset_password', to: 'password_reset#set_new_password'

  # Admin stuff
  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    get '/settings', to: 'settings#edit'
    patch '/settings', to: 'settings#update'
    get '/settings/captcha_system_status', to: 'settings#captcha_system_status'


    scope '/users' do
      get '', to: 'users#index', as: :index_users
      post '', to: 'users#create'
      delete '/:id', to: 'users#destroy', as: :delete_user
      patch '/:id/toggle_activation', to: 'users#toggle_activation', as: :toggle_activation
    end
  end          
end
