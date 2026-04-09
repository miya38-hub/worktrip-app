Rails.application.routes.draw do
  scope module: :public do
    root "homes#top"
    get "/about", to: "homes#about"
  end
end
