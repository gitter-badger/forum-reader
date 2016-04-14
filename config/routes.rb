# coding: utf-8
Rails.application.routes.draw do

  root 'pages#home'

  ###
  # Статические страницы
  #

  controller :pages do
    get 'pages/home'
    get 'pages/help'
    get 'pages/info'
    get 'pages/data'
    get 'pages/settings'
  end

  ###
  #
  #

  resources :contacts, only: [:new, :create]

  get 'locale/change/:lang', to: 'locale#change', as: :change_locale
end
