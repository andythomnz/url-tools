Rails.application.routes.draw do
  root "web_links#new"

  resources :web_links, only: [:new, :create, :show]
  get "/web_links", to: "web_links#new"
  get "/r/:key", to: "web_links#redirect"
end
