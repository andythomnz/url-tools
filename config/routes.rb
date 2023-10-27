Rails.application.routes.draw do
  root "web_links#new"

  get "/web_links", to: "web_links#new"
  get "/r/:key", to: "web_links#redirect"

  resources :web_links, only: [:new, :create]
end
