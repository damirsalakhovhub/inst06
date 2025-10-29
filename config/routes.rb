Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :organizations, only: [] do
    post :switch, on: :collection, as: :switch
  end

  resources :projects do
    resources :tasks
  end

  resources :memberships, only: [ :index, :create, :update, :destroy ]

  mount Avo::Engine, at: Avo.configuration.root_path if defined?(Avo)

  get "up" => "rails/health#show", as: :rails_health_check
end
