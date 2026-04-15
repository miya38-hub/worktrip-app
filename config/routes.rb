Rails.application.routes.draw do
  resources :passwords, param: :token
  
  scope module: :public do
    root "homes#top"
    get "dashboard", to: "homes#dashboard"
    get "/about", to: "homes#about"
    get "/search", to: "searches#search"

    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
      member do
        get :unsubscribe
        patch :withdraw
      end
    end
    
    resource :session, only: [:new, :create, :destroy] do
      post :guest_login
    end

    resources :spots do
      resources :reviews, only: [:create, :edit, :update, :destroy]
      resources :comments, only: [:create, :update, :destroy]
      resource :favorite, only: [:create, :destroy]
    end
  end

  namespace :admin do
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    resources :users, only: [:index, :show] do
      member do
        patch :withdraw
      end
    end

    resources :spots, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, only: [:index, :edit, :update, :destroy]
    end
  end
end