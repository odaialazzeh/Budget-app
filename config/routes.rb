# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:edit, :update, :create]
  resources :groups, only: %i[index new create show destroy edit update] do
    resources :payments, only: %i[index new create show destroy edit update]
  end

  devise_scope :user do
    unauthenticated do
      root 'home#index', as: :unauthenticated_root
    end

    authenticated :user do
      root 'groups#index', as: :authenticated_root
    end
  end
  get '/users/:id', to: 'groups#index'

end
