Rails.application.routes.draw do
  devise_for :users

  resources :repairs, only: [:index, :create]
end
