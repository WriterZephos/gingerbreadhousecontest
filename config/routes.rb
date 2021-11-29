Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Almost every application defines a route for the root path ("/") at the top of this file.
  # root "articles#index"

  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  resources :contests, only: [:show, :new, :create, :edit, :update] do
    resources :entries, only: [:new, :create] do
      post "select_participant", to: "entries#select_participant", on: :collection
    end
    resources :votes, only: [:new, :create] do
      post "select_participant", to: "votes#select_participant", on: :collection
    end
  end
  
  resources :users, only: [:show, :update] do
    resources :participants, shallow: true, only: [:create]
  end
  
  resources :votes, only: [:create]

  root to: "home#index"
end
