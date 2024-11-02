Rails.application.routes.draw do
  namespace :api do
    resource :auth do
      post 'login'
    end
    resources :messages
  end
end
