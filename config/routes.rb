Rails.application.routes.draw do
  namespace :api do
    resource :auth do
      post 'login'
    end
  end
end
