Rails.application.routes.draw do
  root :to => "items#index"

  # Sessions:
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  # Basic resources
  #resources :items, only: [:index, :show]
  resources :users, only: [:new, :index, :create]
  get "/user/edit", to: "users#edit"
  patch "/user/edit", to: "users#update"


  resources :businesses, only: [:index]

  # get '/admin-dashboard', to: 'business_admins#show', as: 'admin_dashboard'

  resources :items, only: [:index, :show] do
    resources :bids, only: [:index, :create]
  end

  # User Dashboard
  get "/dashboard" => "users#show", as: "dashboard"

  # Admin Functionality:
  namespace :platform_admin do
    get "/dashboard", to: "users#show"
  end

  namespace :business_admin do
    get "/dashboard" => "users#show"
  end


  get "/favicon.ico" => "application#get_favicon"
  get "/categories/:id" => "categories#show", as: "category"

  scope '/:slug', as: :business do
    resources :items, only: [:edit, :update]
  end
  
  namespace :business, path: "/:slug", as: :business do
    get "/dashboard", to: "dashboard#show"
  end

  get "/:slug/edit", to: "businesses#edit", as: "edit_business"
  get "/:slug", to: 'businesses#show', as: :business
  patch "/:slug", to: 'businesses#update', as: "update_business"
end
