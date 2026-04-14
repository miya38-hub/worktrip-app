Rails.application.routes.draw do
  resources :passwords, param: :token
  
  scope module: :public do
    root "homes#top"
    get "dashboard", to: "homes#dashboard"
    get "/about", to: "homes#about"
    get "/search", to: "searches#search"

    resources :users, only: [:new, :create, :show, :edit, :update, :destroy] do
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
    end
  end
end