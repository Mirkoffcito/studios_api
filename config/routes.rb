Rails.application.routes.draw do
  namespace :api do
    resources :studios do
      resources :movies do
        resources :characters
      end
      resources :shows do
        resources :characters
      end
    end
  end
end
