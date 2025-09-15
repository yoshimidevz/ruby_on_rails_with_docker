Rails.application.routes.draw do
  devise_for :admins
  resources :comments

  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"
end
