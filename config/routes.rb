Rails.application.routes.draw do
  resources :algorithms, only: [:index, :show, :create]
end
