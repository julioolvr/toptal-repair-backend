Rails.application.routes.draw do
  devise_for :users

  resources :users, only: %i[index show create update destroy]
  resources :repairs, only: %i[index show create update destroy] do
    resources :comments,
              only: %i[index create destroy],
              controller: 'repair_comments',
              shallow: true
  end
end
