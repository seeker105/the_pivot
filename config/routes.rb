Rails.application.routes.draw do
  root :to => "items#index"

  # Sessions:
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Users:
  resources :users, only: [:new, :index, :create]
  get "/user/edit", to: "users#edit"
  patch "/user/edit", to: "users#update"
  get "/dashboard" => "users#show", as: "dashboard"

  # Businesses:
  resources :businesses, only: [:index, :new, :create]

  # Items and Bids:
  resources :items, only: [:index, :show] do
    resources :bids, only: [:index, :create]
  end

  # Admin Functionality:
  namespace :platform_admin do
    get "/dashboard", to: "dashboard#show"
    get "/activate/:slug", to: "dashboard#activate", as: :activate
    get "/deactivate/:slug", to: "dashboard#deactivate", as: :deactivate
  end

  namespace :business_admin do
    get "/dashboard" => "users#show"
  end

  get "/favicon.ico" => "application#get_favicon"
  get "/categories/:id" => "categories#show", as: "category"

  namespace :business, path: "/:slug", as: :business do
    get "/dashboard", to: "dashboard#show"
  end

# ============ Refactor ============================

  scope '/:slug', as: :business do
    get "/", to: 'businesses#show'
    get "/edit", to: "businesses#edit", as: "edit"
    patch "/", to: 'businesses#update', as: "update"
    resources :items, only: [:edit, :update]
  end
end
