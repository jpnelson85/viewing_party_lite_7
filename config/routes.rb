Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "landing#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"

  get "/login", to: 'users#login_form'
  post "/login", to: 'users#login_user'

  delete "/logout", to: "sessions#destroy", as: :logout

  get "/dashboard", to: "users#dashboard"

  # get "/users/", to: "users#show"
  # get "/users/discover", to: "discover#index"
  # get "/users/movies", to: "movies#index"
  # get "/users/movies/:id", to: "movies#show"
  # get "/users/movies/:id/viewing_party/new", to: "viewing_party#new"
  # post "/users/movies/:id/viewing_party", to: "viewing_party#create

  resources :users, only: [:show] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_party, only: [:new, :create]
    end
  end

end
