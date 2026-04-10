Rails.application.routes.draw do
  resources :passwords, param: :token
  
  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about"

    resources :users, only: [:new, :create, :show, :edit, :update, :destroy]
    resource :session, only: [:new, :create, :destroy] do
      post :guest_login
    end
    resources :spots
  end
end
