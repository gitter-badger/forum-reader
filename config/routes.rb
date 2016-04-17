# coding: utf-8
Rails.application.routes.draw do
  root 'pages#home'

  ###
  # Статические страницы
  #

  controller :pages do
    get 'home'
    get 'help'
    get 'info'
    get 'data'
    get 'settings'
  end

  ###
  #
  #

  get 'register', to: redirect('accounts/new'),  as: :register
  get 'login',    to: redirect('sessions/new'),  as: :login
  get 'logout',   to: 'sessions#destroy',        as: :logout

  resources :accounts, except: [:index, :show]

  get 'accounts/confirm_email/:token' =>
      'accounts#confirm_email', as: :confirm_email

  match 'accounts/reset_password' =>
        'accounts#reset_password', via: [:get, :post], as: :reset_password

  ###
  #
  #

  resources :contacts, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  get 'locale/change/:lang', to: 'locale#change', as: :change_locale
end
