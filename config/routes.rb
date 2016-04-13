# coding: utf-8
Rails.application.routes.draw do
  root 'pages#home'

  ###
  # Статические страницы.
  # WARN: алиасы для них не делаем, чтобы небыло накладок с Company#code.
  #

  controller :pages do
    get 'pages/home'
    get 'pages/how'
    get 'pages/info'
    get 'pages/data'
    get 'pages/settings'
  end
end
