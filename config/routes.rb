Rails.application.routes.draw do
  devise_for :users

  resources :repairs, only: %i[index show create update destroy]
end
