# frozen_string_literal: true

Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      resources :movies do
        resources :reviews
      end
    end
  end
end
