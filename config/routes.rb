Rails.application.routes.draw do
  namespace :api do
    resources :studios do
      resources :movies
      resources :shows
    end
    resources :characters

    post 'studios/:studio_id/movies/:movie_id/characters', to: 'movieroles#create'
    get 'studios/:studio_id/movies/:movie_id/characters/:id', to: 'characters#show'
    delete 'studios/:studio_id/movies/:movie_id/characters/:character_id', to: 'movieroles#destroy'

    post 'studios/:studio_id/shows/:show_id/characters', to: 'showroles#create'
    get 'studios/:studio_id/shows/:show_id/characters/:id', to: 'characters#show'
    delete 'studios/:studio_id/shows/:show_id/characters/:character_id', to: 'showroles#destroy'


  end
end
