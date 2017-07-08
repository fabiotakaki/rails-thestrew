Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  devise_for :users
  get 'chat/index'
  root to: 'home#index'
  resources :conversations, param: :id
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
