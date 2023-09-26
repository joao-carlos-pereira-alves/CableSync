Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Especifique a rota para o websocket.
  mount ActionCable.server => '/websocket'
end
