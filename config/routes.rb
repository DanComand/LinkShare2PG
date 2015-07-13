Rails.application.routes.draw do



  root 'lists#index'

  resources :sessions, only: [:new, :create]
  delete '/logout' => 'sessions#destroy'
  resources :favorites
  resources :users, only: [:new, :create, :show, :destroy]
  get 'bookmarks/today' => 'bookmarks#today'
  post 'bookmarks/today' => 'bookmarks#today'
  resources :lists do
    resources :bookmarks, shallow: true do

      end
  end
end