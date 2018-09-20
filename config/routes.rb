# frozen_string_literal: true

Rails.application.routes.draw do
  root 'expenses#index'

  resources :categories, only: %i[index new edit create update destroy]
  resources :expenses, only: %i[index new edit create update destroy]

  namespace :api do
  end

  get '/login', to: 'sessions#new'
  match '/auth/:provider/callback', to: 'sessions#create', via: %i[post get]
  get '/logout', to: 'sessions#destroy'
  get '/no_session', to: 'sessions#missing'
  get '/no_privileges', to: 'sessions#insufficient'
end
