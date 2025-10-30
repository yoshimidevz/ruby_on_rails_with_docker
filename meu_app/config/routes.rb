Rails.application.routes.draw do
  devise_for :admins
  
  # Rotas do sistema de quiz
  resources :quizzes do
    member do
      patch :publish
      get :take_quiz
      get :results
    end
    
    resources :questions do
      resources :answers, only: [:create, :update, :destroy]
    end
  end
  
  # Rotas existentes
  resources :comments
  resources :posts

  get "up" => "rails/health#show", as: :rails_health_check

  root "quizzes#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
