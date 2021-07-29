Rails.application.routes.draw do
  namespace :api do
    resources :studios do
      resources :movies, param: :movie_id
    end
  end
end
