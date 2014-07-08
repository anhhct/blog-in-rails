Rails.application.routes.draw do
  get 'users/new'
  

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :entries, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  root  'static_pages#home'
  match '/compose', to: 'static_pages#compose', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  # match '/help',    to: 'static_pages#help',    via: 'get'
  # match '/about',   to: 'static_pages#about',   via: 'get'
  # match '/contact', to: 'static_pages#contact', via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/users' ,  to:  'users#index' ,        via: 'get'
end
