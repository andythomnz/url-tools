Rails.application.routes.draw do
  root "web_links#index"

  get "/web_links", to: "web_links#index"
  get "/r/:key", to: "web_links#redirect"
end
