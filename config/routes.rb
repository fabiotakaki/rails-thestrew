Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :users
  root to: 'home#index'
  resources :conversations, param: :id
  resources :messages
  resources :chat, only: [:create, :new, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
