Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    resource :auth do
      post 'login'
      post 'register'
    end
    resources :messages, only: [:show, :create]
    resources :reports, only: [:index, :show]
    resource :credits, only: [:show]
    resource :news, only: [:index, :show]
  end
end
