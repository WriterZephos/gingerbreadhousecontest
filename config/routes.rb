Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  resources :contests, only: [:show, :new] do
    post "new", to: "contests#create", as: "", on: :collection
    resources :entries, only: [:new] do
      post "select_participant", to: "entries#select_participant", on: :collection
      post "new", to: "entries#create", as: "", on: :collection
    end
    resources :votes, only: [:new] do
      post "select_participant", to: "votes#select_participant", on: :collection
      post "new", to: "votes#create", as: "", on: :collection
    end
  end
  
  resources :users, only: [:show, :update] do
    resources :participants, shallow: true, only: [:create]
  end
  
  resources :votes, only: [:create]

  root to: "home#index"
end
