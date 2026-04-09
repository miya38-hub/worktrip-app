Rails.application.routes.draw do
  resources :passwords, param: :token
  
  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about"

    resources :users, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]
  end
end
