# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :users do
    get '/sign_in', to: 'devise/sessions#new'
    get '/sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
  end

  devise_for :users, skip: :registrations
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
  end

  authenticate :user do
    root to: 'dashboard#index'

    resources :councilmen do
      get 'projects', to: 'councilmen#projects'
    end

    resources :project_kinds

    resources :projects do
      get 'votes', to: 'projects#votes'
      patch 'votes', to: 'projects#update_votes'
    end

    resources :meetings do
      get 'presents', to: 'meetings#presents'
      patch 'presents', to: 'meetings#update_presents'
      get 'projects', to: 'meetings#projects'
      get 'new', to: 'meetings#new_project'
    end

    resources :political_mandates  do
      get 'councilman', to: 'political_mandate#councilman'
    end

  end
end
