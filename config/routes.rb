Rails.application.routes.draw do
  root :to => "items#index"

  resources :items, only: [:index, :show]
  resources :users, only: [:new, :index, :create]
  resources :businesses, only: [:index, :show, :edit, :update]

  resources :items do
    resources :bids, only: [:index, :create]
  end
  namespace :admin do
    get "/dashboard" => "users#show"
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  patch "/user/edit", to: "users#update"
  get "admin/user/edit" => "users#edit", as: "admin_edit_user"
  get "/user/edit", to: "users#edit", as: "edit_user"
  get "/dashboard" => "users#show", as: "dashboard"
  get "/favicon.ico" => "application#get_favicon"
  get "/categories/:id" => "categories#show", as: "category"
  get "/:slug", to: 'businesses#show', as: :business
end
