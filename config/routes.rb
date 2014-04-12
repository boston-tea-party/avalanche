Avalanche::Application.routes.draw do
  root to: 'uploads#new'
  resources :uploads, only: :create
end
