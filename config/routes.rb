Rails.application.routes.draw do
  apipie

  # Root route
  root to: redirect('/apipie')

  namespace :api do
    namespace :v1 do
      resources :movies do
        resources :reviews, only: [:index, :show, :create, :update, :destroy]
      end
    end
  end
end
