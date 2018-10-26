# frozen_string_literal: true

Rails.application.routes.draw do
  root 'expenses_summary#index'

  resources :categories, only: %i[index new edit create update destroy]
  resources :expenses, only: %i[index new edit create update destroy] do
    collection do
      resources :summary, controller: :expenses_summary, only: [:index] do
        collection do
          get 'top_categories', to: 'expenses_summary#top_categories'
        end
      end

      get :history, to: 'expenses_history#index'

      get :import, to: 'import_expenses#index'
      post :import, to: 'import_expenses#create'
    end
  end
  resources :periodic_expenses, only: %i[index new edit create update destroy]

  namespace :api do
  end

  get '/login', to: 'sessions#new'
  match '/auth/:provider/callback', to: 'sessions#create', via: %i[post get]
  get '/logout', to: 'sessions#destroy'
  get '/no_session', to: 'sessions#missing'
  get '/no_privileges', to: 'sessions#insufficient'
end
