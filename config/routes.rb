# frozen_string_literal: true

Rails.application.routes.draw do
  apipie

  # API routes
  namespace :api do
    namespace :v1 do
      resources :movies do
        resources :reviews, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
end
